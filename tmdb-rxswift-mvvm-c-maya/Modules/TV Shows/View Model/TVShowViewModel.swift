//
//  TVShowViewModel.swift
//  tmdb-rxswift-mvvm-c-maya
//
//  Created by Tanvir Hasan Piash on 13/1/21.
//

import Foundation

struct TVShowViewModel {
    
    private let tvShow: TVShowResult
    
    var posterImage: String {
        return tvShow.posterPath ?? ""
    }
    
    var id: Int {
        return tvShow.id
    }
    
    init(tvShow: TVShowResult) {
        self.tvShow = tvShow
    }
    
}
