//
//  APIService.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 12.03.2024.
//

import Foundation
import PromiseKit

// swiftlint:disable function_body_length

/// Use for sending API request.
///
/// To send a request:
/// ```swift
/// APIService.shared.performRequest<T: HTTPTask>(task: T)
/// ```
public final class APIService {
  public static var shared = APIService()

  private let host: String = ConfigLoader.shared["api_host"]
  private let user: String = ConfigLoader.shared["api_user"]
  private let password: String = ConfigLoader.shared["api_password"]
  private let token: String = UserDefaults.standard.string(for: .authenticationToken) ?? ""
  private let session = URLSession(configuration: .default,
                                   delegate: APIURLSessionDelegate.sessionDelegate,
                                   delegateQueue: nil)
  /// Sends an API request
  /// - Parameter T: ``HTTPTask``
  /// - Returns: ``HTTPTask/ResponseType``
  func performRequest<T: HTTPTask>(task: T) -> Promise<T.ResponseType> {
    return Promise { seal in
      // Check endpoint
      guard let url = URL(string: host + task.endpoint) else {
        seal.reject(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
        return
      }

      // Set HTTP Method, Headers and Parameters
      var request = URLRequest(url: url)
      request.httpMethod = task.method.rawValue
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

      if let parameters = task.parameters {
        do {
          request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch {
          seal.reject(error)
          return
        }
      }

      // Send Request
      print("---------- Sending HTTP Request ---------")
      print("URL: \(String(describing: request.url))")
      print("Method: \(String(describing: request.httpMethod))")

      if let httpBody = request.httpBody {
          let bodyString = String(decoding: httpBody, as: UTF8.self)
          print("Body: \(bodyString)")
      } else {
          print("No HTTP body available")
      }

      print("Headers: \(String(request.value(forHTTPHeaderField: "Authorization")!))")

      session.dataTask(with: request) { data, response, error in
        print("-------- Response HTTP Request ---------")
        if let data = data {
            let responseString = String(decoding: data, as: UTF8.self)
            print("Response Data: \(responseString)")
        } else {
            print("Failed to get response data")
        }

        if let error = error {
          print("Request Error: \(error.localizedDescription)")
          seal.reject(error)
        }

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
          print("Server Error: Response is not 2xx")
          print(self.token)
          seal.reject(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Server Error"]))
          return
        }

        if let mimeType = httpResponse.mimeType, mimeType == "application/json",
           let data = data {
            do {
              let decodedData = try JSONDecoder().decode(T.ResponseType.self, from: data)

              seal.fulfill(decodedData)
            } catch {
              print("Decoding Error: \(error.localizedDescription)")
              seal.reject(error)
            }
        }
        print("-----------------------------------------")
      }.resume()

    }
  }

}

// Perform the request for multiplart upload
extension APIService {
  /**
     Sends a multipart form data request to the server.

     - Parameter task: An object conforming to `HTTPMultipartTask` protocol.
     - Returns: A promise that resolves with the response type or rejects with an error.
    */
  func performMultiplartRequest<T: HTTPMultipartTask>(task: T) -> Promise<T.ResponseType> {
    return Promise { seal in
      guard let url = URL(string: host + task.endpoint) else {
        seal.reject(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
        return
      }

      let boundary = "Boundary-\(UUID().uuidString)"
      var request = URLRequest(url: url)
      request.httpMethod = task.method.rawValue
      request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
      request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

      var body = Data()

      // Append parameters
      if let parameters = task.parameters {
        for (key, value) in parameters {
          body.appendString("--\(boundary)\r\n")
          body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
          body.appendString("\(value)\r\n")
        }
      }

      // Append file data
      body.appendString("--\(boundary)\r\n")
      body.appendString("Content-Disposition: form-data; name=\"file\"; filename=\"\(task.fileName)\"\r\n")
      body.appendString("Content-Type: \(task.mimeType)\r\n\r\n")
      body.append(task.fileData)
      body.appendString("\r\n")
      body.appendString("--\(boundary)--\r\n")

      request.httpBody = body

      // Log the request for debugging
      print("---------- Sending Multipart HTTP Request ---------")
      print("URL: \(request.url?.absoluteString ?? "No URL")")
      print("Method: \(request.httpMethod ?? "No HTTP Method")")
      print("Headers: \(request.allHTTPHeaderFields ?? [:])")
      print("Body Length: \(body.count) bytes")

      // Send request
      session.dataTask(with: request) { data, response, error in
        if let error = error {
          seal.reject(error)
          return
        }

        guard let httpResponse = response as? HTTPURLResponse else {
          seal.reject(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid Response"]))
          return
        }

        if (200...299).contains(httpResponse.statusCode) {
          if let data = data {
            do {
              let decodedData = try JSONDecoder().decode(T.ResponseType.self, from: data)
              seal.fulfill(decodedData)
            } catch {
              seal.reject(error)
            }
          } else {
            seal.reject(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "No Data Received"]))
          }
      } else {
        // Log the response body for debugging
        if let data = data {
          let responseString = String(decoding: data, as: UTF8.self)
          print("Response Data: \(responseString)")
        }
        seal.reject(NSError(domain: "",
                            code: httpResponse.statusCode,
                            userInfo: [NSLocalizedDescriptionKey: "Server Error"]))
      }
    }.resume()
    }
  }
}
// swiftlint:enable function_body_length
