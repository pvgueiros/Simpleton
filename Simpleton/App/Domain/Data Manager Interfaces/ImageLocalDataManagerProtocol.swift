//
//  ImageLocalDataManagerProtocol.swift
//  Simpleton
//
//  Created by Paula Vasconcelos Gueiros on 08/05/25.
//

import Foundation

protocol ImageLocalDataManagerProtocol {
    func getImages() throws -> [SimpletonImageLocal]?
    func saveImages(_ images: [SimpletonImageLocal]) throws
    func saveImageData(_ data: Data, forId id: String, isLarge: Bool) throws
    func getImageData(forId id: String, isLarge: Bool) throws -> Data?
}
