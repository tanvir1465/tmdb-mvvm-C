//
//  TVShowDetailModel.swift
//  tmdb-rxswift-mvvm-c-maya
//
//  Created by Tanvir Hasan Piash on 14/1/21.
//

import UIKit

struct TVShowDetailModel {
    
    let tvShowDetail: TVShowDetail
    
    var backdropPath: String {
        return tvShowDetail.backdropPath
    }
    
    var id: Int {
        return tvShowDetail.id
    }
    
    var originalTitle: String {
        return tvShowDetail.originalName
    }
    
    var title: String {
        return tvShowDetail.name
    }
    
    var tagline: String {
        return tvShowDetail.tagline
    }
    
    var genres: String {
        return tvShowDetail.genres.map({ $0.name }).joined(separator: " | ")
    }
    
    var rating: CGFloat {
        return CGFloat(tvShowDetail.voteAverage * 10)
    }
    
    var overview: String {
        return tvShowDetail.overview
    }
    
    var seasons: Int {
        return tvShowDetail.numberOfSeasons
    }
    
    init(tvShowDetail: TVShowDetail) {
        self.tvShowDetail = tvShowDetail
    }
    
}
