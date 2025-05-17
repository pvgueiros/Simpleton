//
//  MockImageRemoteDataManager.swift
//  Simpleton
//
//  Created by Paula Vasconcelos Gueiros on 07/04/25.
//

import Foundation

struct MockImageRemoteDataManager: ImageRemoteDataManagerProtocol {
    
    var filename = "ImageResponse"
    
    func getImages() throws -> [SimpletonImageDTO] {
        let images: [SimpletonImageDTO] = try MockFileManager.loadJSON(fromFile: filename)
        
        return images
    }
}
