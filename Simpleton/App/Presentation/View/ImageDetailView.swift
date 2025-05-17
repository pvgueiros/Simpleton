//
//  ImageDetailView.swift
//  Simpleton
//
//  Created by Paula Vasconcelos Gueiros on 07/04/25.
//

import SwiftUI

struct ImageDetailView: View {
    @ObservedObject var viewModel: ImageDetailViewModel
    
    var body: some View {
        VStack {
            imageView
            dataView
        }
        .padding()
        .navigationTitle("Image Detail")
    }
    
    var imageView: some View {
        GeometryReader { geo in
            CachedAsyncImage(viewModel: viewModel, isLarge: true)
                .frame(width: geo.size.width, height: geo.size.width)
                .clipped()
        }
        .aspectRatio(1, contentMode: .fill)
    }
    
    var dataView: some View {
        VStack {
            HStack {
                Image(systemName: "heart")
                Text(viewModel.formattedLikes)
                    .accessibilityIdentifier("likes")
                Spacer()
            }
            HStack(alignment: .top) {
                Text(viewModel.username)
                    .bold()
                    .accessibilityIdentifier("username")
                Text(viewModel.title)
                    .accessibilityIdentifier("title")
                Spacer()
            }
            Spacer()
        }
    }
}

#Preview {
    let dependencyContainer = DependencyContainer()
    let mockRemoteDataManager = MockImageRemoteDataManager()
    
    if let image = try? mockRemoteDataManager.getImages().first?.toDomain() {
        ImageDetailView(viewModel: ImageDetailViewModel(getImageDataUseCase: dependencyContainer.getImageDataUseCase, image: image))
    }
}
