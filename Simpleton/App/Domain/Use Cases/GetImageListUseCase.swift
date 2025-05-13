//
//  GetImageListUseCase.swift
//  Simpleton
//
//  Created by Paula Vasconcelos Gueiros on 09/05/25.
//

import Foundation

class GetImageListUseCase {
    
    let repository: ImageRepositoryProtocol
    
    init(repository: ImageRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(isRefreshing: Bool = false) async throws -> [SimpletonImage] {
        try await repository.getImages(remoteOnly: isRefreshing)
    }
}
