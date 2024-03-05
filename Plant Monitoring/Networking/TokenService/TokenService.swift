//
//  TokenService.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 1.03.2024.
//

import Foundation
import PromiseKit

public final class TokenService {
  public static var shared = TokenService()

  let host: String = ConfigLoader.shared["api_host"]
  let user: String = ConfigLoader.shared["api_user"]
  let password: String = ConfigLoader.shared["api_password"]
  let defaults = UserDefaults.standard
  let endpoint = "/GetAuth"

  func start() -> Promise<TokenItem> {
    self.defaults.set(value: "", for: .authenticationToken)

    return Promise { seal in

      // Check endpoint
      guard let url = URL(string: host + endpoint) else {
        seal.reject(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
        return
      }

      var request = URLRequest(url: url)
      request.httpMethod = HTTPMethod.post.rawValue
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")

      let parameters: [String: Any] = [
        "username": user,
        "password": password
      ]

      do {
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
      } catch {
        seal.reject(error)
        return
      }

      print("---------- Sending HTTP Request ---------")
      print("URL: \(String(describing: request.url))")
      print("Method: \(String(describing: request.httpMethod))")
      print("Body: \(String(data: request.httpBody!, encoding: .utf8) ?? "")")

      URLSession.shared.dataTask(with: request) { data, response, error in
        print("-------- Response HTTP Request ---------")
        print("Response Data: \(String(data: data!, encoding: .utf8) ?? "")")
        // print("Response: \(String(describing: response))")

        if let error = error {
          print("Request Error: \(error.localizedDescription)")
          seal.reject(error)
        }

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
          print("Server Error: Response is not 2xx")
          seal.reject(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Server Error"]))
          return
        }

        if let mimeType = httpResponse.mimeType, mimeType == "application/json",
           let data = data {
            do {
              let decodedData = try JSONDecoder().decode(TokenItem.self, from: data)

              self.defaults.set(value: decodedData.accessToken, for: .authenticationToken)

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
