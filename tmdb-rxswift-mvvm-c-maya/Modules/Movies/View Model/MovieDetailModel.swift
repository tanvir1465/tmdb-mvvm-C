//
//  MovieDetailModel.swift
//  tmdb-rxswift-mvvm-c-maya
//
//  Created by Tanvir Hasan Piash on 13/1/21.
//

import UIKit

struct MovieDetailModel {
    
    private let movieDetail: MovieDetail
    
    var backdropPath: String {
        return movieDetail.backdropPath ?? ""
    }
    
    var originalTitle: String {
        return movieDetail.originalTitle
    }
    
    var title: String {
        return movieDetail.title
    }
    
    var tagline: String {
        return movieDetail.tagline
    }
    
    var runtime: String {
        return movieDetail.runtime.toFormattedRuntime
    }
    
    var genres: String {
        return movieDetail.genres.map({ $0.name }).joined(separator: " | ")
    }
    
    var rating: CGFloat {
        return CGFloat(movieDetail.voteAverage * 10)
    }
    
    var overview: String {
        return movieDetail.overview
    }
    
    var imdbId: String {
        return movieDetail.imdbID
    }
    
    init(movieDetail: MovieDetail) {
        self.movieDetail = movieDetail
    }
    
}
