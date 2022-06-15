//
//  Movie.swift
//  MovieApp
//
//  Created by Saurabh Rana on 14/06/22.
//

import Foundation

// MARK: - MovieListModel
struct MovieListModel: Codable {
    let search: [Movie]?
    let totalResults, response, error: String?

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
        case error = "Error"
    }
}

// MARK: - Movie
struct Movie: Codable {
    let title, year, imdbID, type: String
    let poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}
