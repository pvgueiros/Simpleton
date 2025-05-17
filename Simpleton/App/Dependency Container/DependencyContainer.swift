//
//  DependencyContainer.swift
//  Simpleton
//
//  Created by Paula Vasconcelos Gueiros on 13/05/25.
//

import Foundation

class DependencyContainer {
    
    // MARK: - Data Managers
    
    lazy var remoteDataManager = ImageRemoteDataManager()
    lazy var localDataManager = ImageLocalDataManager()
    
    // MARK: - Repositories
    
    lazy var imageRepository = ImageRepository(
        remoteDataManager: remoteDataManager,
        localDataManager: localDataManager
    )
    
    // MARK: - Use Cases
    
    lazy var getImageListUseCase = GetImageListUseCase(repository: imageRepository)
    lazy var getImageDataUseCase = GetImageDataUseCase(repository: imageRepository)
    
    // MARK: - ViewModels
    
    @MainActor
    func makeImageListViewModel() -> ImageListViewModel {
        return ImageListViewModel(
            getImageListUseCase: getImageListUseCase,
            getImageDataUseCase: getImageDataUseCase
        )
    }
}
