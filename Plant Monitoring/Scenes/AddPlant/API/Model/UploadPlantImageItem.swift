//
//  UploadPlantImageItem.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 18.09.2024.
//

import Foundation

/// A model representing the response after uploading a plant image.
///
/// The `UploadPlantImageItem` model contains information about:
/// The plant image upload status, including the plant ID, matched and modified counts, and the uploaded image URL.
public struct UploadPlantImageItem: Codable, Identifiable {
  public let id: String
  let matchedCount: Int
  let modifiedCount: Int
  let upsertedId: String
  let acknowledged: Bool
  let imageUrl: String

  enum CodingKeys: String, CodingKey {
    case id = "plant_id"
    case matchedCount = "matchedCount"
    case modifiedCount = "modifiedCount"
    case upsertedId = "upsertedId"
    case acknowledged = "acknowledged"
    case imageUrl = "imageUrl"
  }
}
