//
//  ImageDTO.swift
//  Simpleton
//
//  Created by Paula Vasconcelos Gueiros on 07/04/25.
//

import Foundation

// MARK: - ImageResponse

struct SimpletonImageDTO: Codable {
    let id: String
    let altDescription: String
    let urls: Urls
    let likes: Int
    let user: User

    enum CodingKeys: String, CodingKey {
        case id, urls, likes, user
        case altDescription = "alt_description"
    }
    
    // MARK: - Urls
    
    struct Urls: Codable {
        let thumb, full: String
        let raw, regular, small, smallS3: String?

        enum CodingKeys: String, CodingKey {
            case raw, full, regular, small, thumb
            case smallS3 = "small_s3"
        }
    }

    // MARK: - User
    
    struct User: Codable {
        let username: String
        let id: String?

        enum CodingKeys: String, CodingKey {
            case id, username
        }
    }
    
    // MARK: - Mapping to/from Domain Data Type
    
    func toDomain() -> SimpletonImage {
        SimpletonImage(
            id: id,
            title: altDescription,
            urls: SimpletonImage.URLs(
                small: urls.thumb,
                large: urls.full
            ),
            likes: likes,
            username: user.username,
            timestamp: Date()
        )
    }
}
