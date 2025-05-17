//
//  GetImageListUseCaseTests.swift
//  SimpletonTests
//
//  Created by Paula Vasconcelos Gueiros on 16/05/25.
//

import Testing
@testable import Simpleton

struct GetImageListUseCaseTests {
    
    

    @Test func testGetImagesRemote() async throws {
        let localDataManager = ImageLocalDataManager()
        let remoteDataManager = ImageRemoteDataManager()
        let repository = ImageRepository(remoteDataManager: remoteDataManager, localDataManager: localDataManager)
        let getImageListUseCase = GetImageListUseCase(repository: repository)
        
        let images = try await getImageListUseCase.execute()
        #expect(images.count == 10)
        #expect(images.first != nil)
    }

}
