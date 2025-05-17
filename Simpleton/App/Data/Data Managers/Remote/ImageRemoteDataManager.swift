//
//  ImageRemoteDataManager.swift
//  Simpleton
//
//  Created by Paula Vasconcelos Gueiros on 07/04/25.
//

import Foundation

struct ImageRemoteDataManager: ImageRemoteDataManagerProtocol {
    
    func getImages() async throws -> [SimpletonImageDTO] {
        let url = "https://api.unsplash.com/photos/?client_id=w3RfaqXkhVmuodyyszutfM1dN-hy3v7m2t-9SA3klkc"
        let images = try await NetworkManager.request(url: url, type: [SimpletonImageDTO].self) ?? [SimpletonImageDTO]()
        
        return images
    }
}
