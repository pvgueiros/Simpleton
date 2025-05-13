//
//  GetImageDataUseCase.swift
//  Simpleton
//
//  Created by Paula Vasconcelos Gueiros on 12/05/25.
//

import Foundation

class GetImageDataUseCase {

    let repository: ImageRepositoryProtocol
    
    init(repository: ImageRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(forId id: String, url: String, isLarge: Bool = false) async throws -> Data {
        try await repository.getImageData(forId: id, url: url, isLarge: isLarge)
    }
}
