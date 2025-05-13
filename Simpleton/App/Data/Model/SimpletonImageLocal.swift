//
//  SimpletonImageLocal.swift
//  Simpleton
//
//  Created by Paula Vasconcelos Gueiros on 09/05/25.
//

import Foundation

struct SimpletonImageLocal: Codable {
    let id: String
    let title: String
    let urls: URLs
    let likes: Int
    let username: String
    let timestamp: Date
    
    struct URLs: Codable {
        let small: String
        let large: String
    }
    
    func toDomain() -> SimpletonImage {
        SimpletonImage(
            id: id,
            title: title,
            urls: SimpletonImage.URLs(
                small: urls.small,
                large: urls.large
            ),
            likes: likes,
            username: username,
            timestamp: timestamp
        )
    }
    
    init(fromDomain domain: SimpletonImage) {
        self.id = domain.id
        self.title = domain.title
        self.urls = URLs(small: domain.urls.small, large: domain.urls.large)
        self.likes = domain.likes
        self.username = domain.username
        self.timestamp = domain.timestamp
    }
}
