//
//  SimpletonApp.swift
//  Simpleton
//
//  Created by Paula Vasconcelos Gueiros on 04/04/25.
//

import SwiftUI

@main
struct SimpletonApp: App {
    let dependencyContainer = DependencyContainer()
    
    var body: some Scene {
        WindowGroup {
            ImageGridView(viewModel: dependencyContainer.makeImageListViewModel())
        }
    }
}
