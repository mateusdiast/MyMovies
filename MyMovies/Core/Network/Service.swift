//
//  Service.swift
//  MyMovies
//
//  Created by Mateus Dias on 30/11/24.
//

import Foundation
import Combine

protocol ServiceProtocol {
    func request<T: Decodable>(urlPath: String, model: T.Type) -> AnyPublisher<T, ServiceError>
}


final class Service {
    
    static var shared: Service = Service()
    
    func request<T: Decodable>(urlPath: String, model: T.Type) -> AnyPublisher<T, ServiceError> {
        
        let task = URLSession.shared.dataTaskPublisher(for: URL(string: urlPath)!)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> ServiceError in
                if let _ = error as? URLError {
                    return .invalidUrl
                } else if let _ = error as? DecodingError {
                    return .decodeFail
                } else {
                    return .undefined
                }
            }
            .eraseToAnyPublisher()
        
        return task
        
    }
    
    private init() {}
    
    
}
