//
//  Movie.swift
//  MyMovies
//
//  Created by Mateus Dias on 30/11/24.
//
import Foundation


struct Movie: Codable {
    let results: [Results]
}

struct Results: Codable {
    let id: Int
    let title: String
    let poster_path: String
}
