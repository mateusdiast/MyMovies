//
//  HomeViewModel.swift
//  MyMovies
//
//  Created by Mateus Dias on 30/11/24.
//

import Foundation
import Combine

protocol HomeViewModelProtocol: ObservableObject {
    var item: [Item] { get set }
    var isShowAlert: Bool { get set }
    var isLoading: Bool { get set }
    func onLoad()
}

final class HomeViewModel: HomeViewModelProtocol {
    
    @Published var item: [Item] = []
    @Published var isShowAlert: Bool = false
    @Published var isLoading: Bool = true
    
    private var cancellables: Set<AnyCancellable> = []
    
    
    func onLoad() {
        
        self.item = []
        
        let request = Service.shared
            .request(
                urlPath: Paths.baseURL + Paths.apiKey,
                model: Movie.self
            )
        
        request.sink { completion in
            DispatchQueue.main.async {
                switch completion {
                case .failure:
                    self.isShowAlert = true
                case .finished:
                    self.isShowAlert = false
                }
            }
        } receiveValue: { data in
            let movies: [Item] = data.results.map({ data in
                let item = Item(
                    title: data.title,
                    id: data.id,
                    url: Paths.baseUrlImage + data.poster_path
                )
                return item
            })
            
            DispatchQueue.main.async {
                self.item.append(contentsOf: movies)
                self.isLoading = false
            }
            
        }.store(in: &cancellables)
    }
}
