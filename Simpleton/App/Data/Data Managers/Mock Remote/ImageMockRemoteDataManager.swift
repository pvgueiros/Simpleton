//
//  ImageMockRemoteDataManager.swift
//  Simpleton
//
//  Created by Paula Vasconcelos Gueiros on 07/04/25.
//

import Foundation

struct ImageMockRemoteDataManager: ImageRemoteDataManagerProtocol {
    
    func getImages() throws -> [SimpletonImageResponse] {
        let images: [SimpletonImageResponse] = try MockFileManager.loadJSON(fromFile: "ImageResponse")
        
        return images
    }
}
