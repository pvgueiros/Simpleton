//
//  MockFileManager.swift
//  Simpleton
//
//  Created by Paula Vasconcelos Gueiros on 07/05/25.
//

import Foundation

struct MockFileManager {
    
    static func loadJSON<T: Decodable>(fromFile filename: String) throws -> T {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            print("❌ Could not find \(filename).json in bundle.")
            throw MockFileManagerError.fileNotFound
        }
        
        guard let data = try? Data(contentsOf: url) else {
            print("❌ Could not load data from \(filename).json")
            throw MockFileManagerError.couldNotLoadData
        }

        let decoder = JSONDecoder()
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print("❌ Decoding error: \(error)")
            throw MockFileManagerError.couldNotDecode
        }
    }
}

enum MockFileManagerError: String, LocalizedError {
    case fileNotFound
    case couldNotLoadData
    case couldNotDecode
    
    var errorDescription: String? {
        return self.rawValue
    }
}
