//
//  MovieViewModel.swift
//  tmdb-rxswift-mvvm-c-maya
//
//  Created by Tanvir Hasan Piash on 13/1/21.
//

import Foundation

struct MovieViewModel {
    
    private let movie: MovieResult
    
    var posterImage: String {
        return movie.posterPath ?? ""
    }
    
    var id: Int {
        return movie.id
    }
    
    init(movie: MovieResult) {
        self.movie = movie
    }
    
}
