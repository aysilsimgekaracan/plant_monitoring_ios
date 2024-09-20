//
//  UploadPlantImageTask.swift
//  Plant Monitoring
//
//  Created by Ayşıl Simge Karacan on 18.09.2024.
//

import Foundation

/// Task for uploading a plant image via multipart form data.
public struct UploadPlantImageTask: HTTPMultipartTask {
  // MARK: Properties

  var fileData: Data

  var fileName: String

  var mimeType: String = "image/jpeg"

  var endpoint: String = "/UploadPlantImage/"

  var method: HTTPMethod = .post

  var parameters: [String: Any]?

  var additionalHeaders: [String: Any]?

  typealias ResponseType = UploadPlantImageItem

  // MARK: Initializer
  /// Initializes a new task for uploading a plant image.
  /// - Parameters:
  ///   - plantId: The plant ID to associate the image with.
  ///   - fileData: The image data being uploaded.
  ///   - fileName: The name of the file being uploaded.
  public init(plantId: String, fileData: Data, fileName: String = "image.jpg") {
    self.parameters = ["plant_id": plantId]
    self.fileData = fileData
    self.fileName = fileName
  }
}
