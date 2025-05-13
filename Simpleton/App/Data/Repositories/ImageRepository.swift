//
//  ImageRepository.swift
//  Simpleton
//
//  Created by Paula Vasconcelos Gueiros on 07/04/25.
//

import Foundation

struct ImageRepository: ImageRepositoryProtocol {
    
    var remoteDataManager: ImageRemoteDataManagerProtocol
    var localDataManager: ImageLocalDataManagerProtocol
    
    let cacheExpirationTimeInterval: TimeInterval = 1800
    
    init(remoteDataManager: ImageRemoteDataManagerProtocol,
         localDataManager: ImageLocalDataManagerProtocol) {
        
        self.remoteDataManager = remoteDataManager
        self.localDataManager = localDataManager
    }
    
    func getImages(remoteOnly: Bool) async throws -> [SimpletonImage] {
        do {
            if !remoteOnly,
               let cachedImages = try getImagesFromCache(),
               let first = cachedImages.first {
                print("✅ Found data in cache")
                
                if first.timestamp.timeIntervalSinceNow > -cacheExpirationTimeInterval {
                    print("✅ Time interval is valid: \(first.timestamp.timeIntervalSinceNow)")
                    return cachedImages
                } else {
                    print("⚠️ Disk cache expired")
                }
            }
        } catch {
            print("❌ Could not retrieve cached images")
        }
        
        print("🔄 Fetching data from remote server...")
        let images = try await getImagesFromRemote()

        do {
            try saveImages(images)
            print("✅ Saved updated images to cache")
        } catch {
            print("❌ Could not save images to cache")
        }
        return images
    }
    
    private func getImagesFromRemote() async throws -> [SimpletonImage] {
        try await remoteDataManager.getImages().map { $0.toDomain() }
    }
    
    private func getImagesFromCache() throws -> [SimpletonImage]? {
        try localDataManager.getImages()?.map { $0.toDomain() }
    }
    
    private func saveImages(_ images: [SimpletonImage]) throws {
        try localDataManager.saveImages(images.map { SimpletonImageLocal(fromDomain: $0) })
    }
    
    func getImageData(forId id: String, url: String, isLarge: Bool = false) async throws -> Data {
        if let cachedData = try getImageData(forId: id, isLarge: isLarge) {
            print("✅ Found image data in cache")
            return cachedData
        }
        
        print("🔄 Downloading image data from URL...")
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        do {
            try saveImageData(data, forId: id, isLarge: isLarge)
            print("✅ Saved image data to cache")
        } catch {
            print("❌ Could not save image data to cache")
        }
        
        return data
    }
    
    private func getImageData(forId id: String, isLarge: Bool) throws -> Data? {
        try localDataManager.getImageData(forId: id, isLarge: isLarge)
    }
    
    private func saveImageData(_ data: Data, forId id: String, isLarge: Bool) throws {
        try localDataManager.saveImageData(data, forId: id, isLarge: isLarge)
    }
}

