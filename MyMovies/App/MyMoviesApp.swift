//
//  MyMoviesApp.swift
//  MyMovies
//
//  Created by Mateus Dias on 29/11/24.
//

import SwiftUI

@main
struct MyMoviesApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel())
        }
    }
}
