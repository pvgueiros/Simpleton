//
//  ImageRepositoryProtocol.swift
//  Simpleton
//
//  Created by Paula Vasconcelos Gueiros on 09/05/25.
//

import Foundation

protocol ImageRepositoryProtocol {
    func getImages(remoteOnly: Bool) async throws -> [SimpletonImage]
    func getImageData(forId id: String, url: String, isLarge: Bool) async throws -> Data
}
