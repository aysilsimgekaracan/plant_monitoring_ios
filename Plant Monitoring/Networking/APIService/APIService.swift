//
//  APIService.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 12.03.2024.
//

import Foundation
import PromiseKit

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
      print("Body: \(String(data: request.httpBody ?? Data(), encoding: .utf8) ?? "")")
      print("Headers: \(String(request.value(forHTTPHeaderField: "Authorization")!))")

      session.dataTask(with: request) { data, response, error in
        print("-------- Response HTTP Request ---------")
        print("Response Data: \(String(data: data!, encoding: .utf8) ?? "")")

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
