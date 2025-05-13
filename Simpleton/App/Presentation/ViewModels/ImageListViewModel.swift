//
//  ImageListViewModel.swift
//  Simpleton
//
//  Created by Paula Vasconcelos Gueiros on 07/04/25.
//

import Foundation

@MainActor
class ImageListViewModel: ObservableObject {
    
    enum State {
        case loading
        case success(images: [SimpletonImage])
        case error(message: String)
    }
    
    private var getImageListUseCase: GetImageListUseCase
    private var getImageDataUseCase: GetImageDataUseCase
    
    private var detailViewModels: [ImageDetailViewModel] = []
    @Published var state: State = .loading
    
    init(getImageListUseCase: GetImageListUseCase, getImageDataUseCase: GetImageDataUseCase) {
        self.getImageListUseCase = getImageListUseCase
        self.getImageDataUseCase = getImageDataUseCase
    }
    
    // MARK: - Public Interface
    
    func getImages(isRefreshing: Bool = false) async {
        do {
            state = .loading
            let images = try await getImageListUseCase.execute(isRefreshing: isRefreshing)
            detailViewModels = images.map { ImageDetailViewModel(getImageDataUseCase: getImageDataUseCase, image: $0) }
            state = .success(images: images)
        } catch {
            print("❌ Could not retrieve images: \(error.localizedDescription)")
            state = .error(message: error.localizedDescription)
        }
    }
    
    func detailViewModel(forId id: String) -> ImageDetailViewModel? {
        return detailViewModels.first(where: { $0.id == id })
    }
}
