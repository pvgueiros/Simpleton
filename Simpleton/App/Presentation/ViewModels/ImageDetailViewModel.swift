//
//  ImageDetailViewModel.swift
//  Simpleton
//
//  Created by Paula Vasconcelos Gueiros on 12/05/25.
//

import SwiftUI

@MainActor
class ImageDetailViewModel: ObservableObject {
    
    enum State {
        case loading
        case success(imageData: Data)
        case error(message: String)
    }
    
    private var getImageDataUseCase: GetImageDataUseCase
    
    private let image: SimpletonImage
    @Published var state: State = .loading
    
    init(getImageDataUseCase: GetImageDataUseCase, image: SimpletonImage) {
        self.getImageDataUseCase = getImageDataUseCase
        self.image = image
    }
    
    // MARK: - Public Interface
    
    var formattedLikes: String {
        "\(image.likes)"
    }
    
    var username: String {
        image.username
    }
    
    var title: String {
        image.title
    }
    
    var id: String {
        image.id
    }
    
    func loadImageData(isLarge: Bool = false) async {
        do {
            state = .loading
            let url = isLarge ? image.urls.large : image.urls.small
            let imageData = try await getImageDataUseCase.execute(forId: image.id, url: url, isLarge: isLarge)
            state = .success(imageData: imageData)
        } catch {
            print("❌ Could not retrieve image Data: \(error.localizedDescription)")
            state = .error(message: error.localizedDescription)
        }
    }
}
