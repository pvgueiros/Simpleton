//
//  SimpletonApp.swift
//  Simpleton
//
//  Created by Paula Vasconcelos Gueiros on 04/04/25.
//

import SwiftUI

@main
struct SimpletonApp: App {
    var body: some Scene {
        WindowGroup {
            let remoteDataManager = ImageRemoteDataManager()
            let localDataManager = ImageLocalDataManager()
            let imageRepository = ImageRepository(
                remoteDataManager: remoteDataManager,
                localDataManager: localDataManager
            )
            let getImageListUseCase = GetImageListUseCase(repository: imageRepository)
            let getImageDataUseCase = GetImageDataUseCase(repository: imageRepository)
            let viewModel = ImageListViewModel(getImageListUseCase: getImageListUseCase, getImageDataUseCase: getImageDataUseCase)
            
            ImageGridView(viewModel: viewModel)
        }
    }
}
