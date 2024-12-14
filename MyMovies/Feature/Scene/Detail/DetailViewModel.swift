//
//  DetailViewModel.swift
//  MyMovies
//
//  Created by Mateus Dias on 01/12/24.
//

import Foundation
import Combine

protocol DetailViewModelProtocol: ObservableObject {
    var item: ItemDetail? { get set }
    var isShowAlert: Bool { get set }
    var isLoading: Bool { get set }
    func onLoad(id: Int)
}

final class DetailViewModel: DetailViewModelProtocol {
    
    @Published var item: ItemDetail?
    @Published var isShowAlert: Bool = false
    @Published var isLoading: Bool = false
    
    private var cancellables: Set<AnyCancellable> = []
    
    func onLoad(id: Int) {
        
        let request = Service.shared.request( urlPath: Paths.baseDetailUrl + "\(id)" + Paths.apiKey, model: MovieDetail.self)

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
            let genres = data.genres.map({$0.name})
            
            DispatchQueue.main.async {
                self.item = ItemDetail(
                    title: data.title,
                    description: data.overview,
                    image: Paths.baseUrlImage + data.backdrop_path + Paths.apiKey,
                    imdb_id: data.imdb_id,
                    release_date: data.release_date,
                    genre: genres
                )
                self.isLoading = false
            }
        }.store(in: &cancellables)
        
        
    }
}
