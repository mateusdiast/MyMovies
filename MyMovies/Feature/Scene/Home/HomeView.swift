//
//  ContentView.swift
//  MyMovies
//
//  Created by Mateus Dias on 29/11/24.
//

import SwiftUI

@MainActor
struct HomeView<ViewModel: HomeViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.isLoading == false {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.item, id: \.id) { item in
                            ZStack {
                                NavigationLink(
                                    destination: DetailView(id: item.id, viewModel: DetailViewModel())) {
                                        VStack {
                                            AsyncImage(url: URL(string: item.url)) { phase in
                                                switch phase {
                                                case .empty:
                                                    ProgressView()
                                                        .frame(height: 200)
                                                        .cornerRadius(10)
                                                case .success(let image):
                                                    image
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(height: 200)
                                                        .background(Color.gray)
                                                        .cornerRadius(10)
                                                case .failure:
                                                    Color.white
                                                        .frame(height: 200)
                                                        .cornerRadius(10)
                                                @unknown default:
                                                    EmptyView()
                                                }
                                            }
                                            Text(item.title)
                                                .foregroundColor(.white)
                                            
                                        }
                                    }
                            }
                        }
                    }
                    .padding()
                } else {
                    VStack {
                        Text("Loading...")
                        ProgressView()
                    } 
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .background(Color.black.edgesIgnoringSafeArea(.bottom))
            .onAppear() {
                viewModel.onLoad()
            }
        }
        .alert("Error", isPresented: $viewModel.isShowAlert) {
            Button("Try again") {
                viewModel.onLoad()
            }
        } message: {
            Text("Something went wrong!")
        }
    }
}

#Preview {
    HomeView()
}
