//
//  ImageLocalDataManager.swift
//  Simpleton
//
//  Created by Paula Vasconcelos Gueiros on 08/05/25.
//

import Foundation

struct ImageLocalDataManager: ImageLocalDataManagerProtocol {
    
    private let userDefaults = UserDefaults.standard
    
    private let fileManager = FileManager.default
    private let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    private let rootImagesKey: String = "rootImages"
    private let imageKeyPrefix: String = "image"
    private let smallImageSuffix: String = "small"
    private let largeImageSuffix: String = "large"
    
    func getImages() throws -> [SimpletonImageLocal]? {
        guard let data = userDefaults.data(forKey: rootImagesKey) else {
            return nil
        }
        
        do {
            return try JSONDecoder().decode([SimpletonImageLocal].self, from: data)
        } catch {
            print("❌ Could not decode image data from file \(rootImagesKey)")
            throw LocalFileManagerError.couldNotDecodeData
        }
    }
    
    func saveImages(_ images: [SimpletonImageLocal]) throws {
        let data = try JSONEncoder().encode(images)
        userDefaults.set(data, forKey: rootImagesKey)
    }
    
    func saveImageData(_ data: Data, forId id: String, isLarge: Bool = false) throws {
        let suffix = isLarge ? largeImageSuffix : smallImageSuffix
        let fileName = "\(imageKeyPrefix)_\(id)_\(suffix)"
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        do {
            try data.write(to: fileURL)
        } catch {
            print("❌ Failed to save image: \(error)")
            throw LocalFileManagerError.couldNotSaveImage
        }
    }
    
    func getImageData(forId id: String, isLarge: Bool = false) throws -> Data? {
        let suffix = isLarge ? largeImageSuffix : smallImageSuffix
        let fileName = "\(imageKeyPrefix)_\(id)_\(suffix)"
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard fileManager.fileExists(atPath: fileURL.path) else { return nil }
        
        do {
            return try Data(contentsOf: fileURL)
        } catch {
            print("❌ Failed to read image data: \(error)")
            throw LocalFileManagerError.couldNotReadImage
        }
    }
}

enum LocalFileManagerError: String, LocalizedError {
    case couldNotSaveImage
    case couldNotDecodeData
    case couldNotReadImage
    
    var errorDescription: String? {
        return self.rawValue
    }
}
