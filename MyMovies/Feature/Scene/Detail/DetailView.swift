//
//  DetailView.swift
//  MyMovies
//
//  Created by Mateus Dias on 01/12/24.
//

import SwiftUI


struct DetailView<ViewModel: DetailViewModelProtocol>: View {
    
    private let id: Int
    @ObservedObject var viewModel: ViewModel
    
    init(id: Int, viewModel: ViewModel) {
        self.id = id
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            
            if viewModel.isLoading == false {
                AsyncImage(
                url: URL(string: viewModel.item?.image ?? "" )
            ) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 150, height: 150)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .background(Color.gray)
                case .failure:
                    Color.gray
                        .frame(width: 150, height: 150)
                @unknown default:
                    EmptyView()
                }
            }
            Text(viewModel.item?.title ?? "")
                .font(.title)
                .padding(5)
            HStack {
                Text(String().formattedYear(from: viewModel.item?.release_date ?? "" ))
                    .font(.caption2)
                    .tint(.gray)
                Text("•")
                
                Text((viewModel.item?.genre ?? []).joined(separator: ", "))
                    .font(.caption2)
                    .tint(.yellow)
                
               
            }
            .padding(3)
            
            Text("Overview:")
                .font(.headline)
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
                .background(Color.gray)
            Text(viewModel.item?.description ?? "")
                .font(.caption)
                .padding(10)
                .tint(.gray)
            
            Button(action: {}) {
                Text("Watch Now")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding()
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: 45
                    )
                    .background(Color.white)
                    .cornerRadius(10)
            }
            .padding(15)
            Spacer()
            } else {
                Text("Loading...")
                ProgressView()
            }
        }
        .background(Color.black.ignoresSafeArea())
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            viewModel.onLoad(id: id)
        }
        .alert("Error", isPresented: $viewModel.isShowAlert) {
                   Button("Try again") {
                       viewModel.onLoad(id: id)
                   }
               } message: {
                   Text("Something went wrong!")
        }
    }
}

#Preview {
    DetailView(id: 5453)
}
