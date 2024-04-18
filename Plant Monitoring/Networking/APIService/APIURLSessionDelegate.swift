//
//  APIURLSessionDelegate.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 12.03.2024.
//

import Foundation

public final class APIURLSessionDelegate: NSObject, URLSessionTaskDelegate {
  public static let sessionDelegate = APIURLSessionDelegate()
  private let token: String = UserDefaults.standard.string(for: .authenticationToken) ?? ""

  public func urlSession(_ session: URLSession,
                         task: URLSessionTask,
                         willPerformHTTPRedirection response: HTTPURLResponse,
                         newRequest request: URLRequest,
                         completionHandler: @escaping (URLRequest?) -> Void) {
        var newRequest = request
        // Set the Authorization header on the new request
        newRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        completionHandler(newRequest)
    }
}
