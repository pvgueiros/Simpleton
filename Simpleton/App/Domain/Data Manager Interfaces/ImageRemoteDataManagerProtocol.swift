//
//  ImageRemoteDataManagerProtocol.swift
//  Simpleton
//
//  Created by Paula Vasconcelos Gueiros on 07/04/25.
//

import Foundation

protocol ImageRemoteDataManagerProtocol {
    func getImages() async throws -> [SimpletonImageResponse]
}
