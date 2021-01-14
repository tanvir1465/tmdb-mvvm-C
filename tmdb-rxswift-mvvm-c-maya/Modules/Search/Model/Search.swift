//
//  Search.swift
//  tmdb-rxswift-mvvm-c-maya
//
//  Created by Tanvir Hasan Piash on 13/1/21.
//

import Foundation

struct Search: Codable {
    let page: Int
    let results: [SearchResult]
}

struct SearchResult: Codable {
    let id: Int
    let name: String?
    let title: String?
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, title
        case posterPath = "poster_path"
    }
}
