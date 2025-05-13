//
//  ImageDTO.swift
//  Simpleton
//
//  Created by Paula Vasconcelos Gueiros on 07/04/25.
//

import Foundation

// MARK: - ImageResponse

struct SimpletonImageResponse: Codable {
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
        
        init(thumb: String, full: String, raw: String? = nil, regular: String? = nil, small: String? = nil, smallS3: String? = nil) {
            self.thumb = thumb
            self.full = full
            self.raw = raw
            self.regular = regular
            self.small = small
            self.smallS3 = smallS3
        }
    }

    // MARK: - User
    
    struct User: Codable {
        let username: String
        let id: String?

        enum CodingKeys: String, CodingKey {
            case id, username
        }
        
        init(username: String, id: String? = nil) {
            self.username = username
            self.id = id
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
    
    init(fromDomain domain: SimpletonImage) {
        self.id = domain.id
        self.altDescription = domain.title
        self.urls = Urls(thumb: domain.urls.small, full: domain.urls.large)
        self.likes = domain.likes
        self.user = User(username: domain.username)
    }
}
