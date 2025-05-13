//
//  CachedAsyncImage.swift
//  Simpleton
//
//  Created by Paula Vasconcelos Gueiros on 09/05/25.
//

import SwiftUI

struct CachedAsyncImage: View {
    
    @ObservedObject var viewModel: ImageDetailViewModel
    private let isLarge: Bool
    
    init(viewModel: ImageDetailViewModel, isLarge: Bool = false) {
        self.viewModel = viewModel
        self.isLarge = isLarge
    }
    
    var body: some View {
        decisionView
        .task {
            await viewModel.loadImageData(isLarge: isLarge)
        }
    }
    
    @ViewBuilder
    var decisionView: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
        case .success(let imageData):
            if let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            }
        case .error:
            Text("⚠️")
        }
    }
} 
