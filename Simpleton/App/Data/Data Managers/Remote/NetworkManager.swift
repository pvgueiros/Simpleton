//
//  NetworkManager.swift
//  Simpleton
//
//  Created by Paula Vasconcelos Gueiros on 07/04/25.
//

import Foundation

struct NetworkManager {
    
    static let session = URLSession.shared
    
    static func request<T: Decodable>(url: String, type: T.Type) async throws -> T? {
        
        guard let url = URL(string: url) else {
            print("❌ Could not create URL from \(url)")
            throw NetworkError.badURL
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            print("❌ Could not cast response to HTTPURLResponse")
            throw NetworkError.badResponse
        }
        guard response.statusCode == 200 else {
            print("❌ Status code \(response.statusCode) is unacceptable")
            throw NetworkError.unacceptableStatusCode
        }
        guard let object = try? JSONDecoder().decode(T.self, from: data) else {
            print("❌ Could not decode to \(T.self)")
            throw NetworkError.couldNotDecode
        }
        
        return object
    }
}

enum NetworkError: String, LocalizedError {
    case badURL
    case badResponse
    case couldNotDecode
    case unacceptableStatusCode
    
    var errorDescription: String? {
        return self.rawValue
    }
}
