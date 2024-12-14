//
//  MovieDetail.swift
//  MyMovies
//
//  Created by Mateus Dias on 01/12/24.
//

struct MovieDetail: Codable {
    let id: Int
    let title: String
    let poster_path: String
    let backdrop_path: String
    let imdb_id: String
    let release_date: String
    let overview: String
    let genres: [Genres]
}

struct Genres: Codable {
    let id: Int
    let name: String
}
