//
//  SimpletonImage.swift
//  Simpleton
//
//  Created by Paula Vasconcelos Gueiros on 07/04/25.
//

import Foundation

struct SimpletonImage: Identifiable, Hashable {
    struct URLs: Hashable {
        let small: String
        let large: String
    }
    
    let id: String
    let title: String
    let urls: URLs
    let likes: Int
    let username: String
    let timestamp: Date
}
