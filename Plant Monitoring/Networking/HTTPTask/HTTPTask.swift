//
//  HTTPTask.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 29.02.2024.
//

import Foundation

public enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
}

protocol HTTPTask {
  associatedtype ResponseType: Codable, Decodable
  var endpoint: String { get }
  var method: HTTPMethod { get }
  var parameters: [String: Any]? { get }
  var additionalHeaders: [String: Any]? { get }
}
