//
//  ServiceError.swift
//  MyMovies
//
//  Created by Mateus Dias on 02/12/24.
//

enum ServiceError: Error {
    case network
    case invalidUrl
    case decodeFail
    case undefined
}
