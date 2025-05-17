//
//  ImageGridView.swift
//  Simpleton
//
//  Created by Paula Vasconcelos Gueiros on 04/04/25.
//

import SwiftUI

struct ImageGridView: View {
    struct Constant {
        static let imageSize: CGFloat = 100.0
        static let defaultSpacing: CGFloat = 100.0
    }
    
    @ObservedObject var viewModel: ImageListViewModel
    @State private var didLoad = false
    
    var body: some View {
        NavigationStack {
            decisionView
        }
        .task {
            guard !didLoad else { return }
            didLoad = true
            await viewModel.getImages()
        }
    }
    
    @ViewBuilder
    var decisionView: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
        case .success(let images):
            baseContentView(for: images)
        case .error(let message):
            Text("Unable to retrieve photos").font(.title)
            Text(message).font(.headline)
        }
    }
    
    func baseContentView(for images: [SimpletonImage]) -> some View {
        ScrollView {
            HStack {
                Text("Select an Image to see its detail")
                    .accessibilityIdentifier("descriptionText")
                Spacer()
            }
            .padding()
            gridView(for: images)
        }
        .accessibilityIdentifier("scrollView")
        .refreshable {
            await viewModel.getImages(isRefreshing: true)
        }
        .navigationTitle("Image Grid")
    }
    
    func gridView(for images: [SimpletonImage]) -> some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: Constant.imageSize), spacing: Constant.defaultSpacing)]) {
            ForEach(images) { image in
                NavigationLink(value: image) {
                    imageView(for: image)
                        .accessibilityIdentifier("imageView")
                }
            }
        }
        .accessibilityIdentifier("gridView")
        .navigationDestination(for: SimpletonImage.self) { image in
            if let viewModel = viewModel.detailViewModel(forId: image.id) {
                ImageDetailView(viewModel: viewModel)
            }
        }
    }
    
    @ViewBuilder
    func imageView(for image: SimpletonImage) -> some View {
        let _ = print("imageView_\(image.id)")
        if let viewModel = viewModel.detailViewModel(forId: image.id) {
            CachedAsyncImage(viewModel: viewModel, isLarge: false)
                .frame(width: Constant.imageSize, height: Constant.imageSize)
                .clipped()
        }
    }
}

#Preview {
    let dependencyContainer = DependencyContainer()
    ImageGridView(viewModel: dependencyContainer.makeImageListViewModel())
}
