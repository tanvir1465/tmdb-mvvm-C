//
//  MovieDetailViewModel.swift
//  tmdb-rxswift-mvvm-c-maya
//
//  Created by Tanvir Hasan Piash on 13/1/21.
//

import Foundation
import RxSwift
import RxCocoa

final class MovieDetailViewModel {
    
    private let movieService: MovieServiceProtocol
    
    init(movieService: MovieServiceProtocol = MovieService()) {
        
        self.movieService = movieService
        
    }
    
    func fetchMovieDetailModel(id: Int) -> Observable<MovieDetailModel> {
        
        movieService.fetchMovieDetails(id: id).map { (detail) in
            
            MovieDetailModel.init(movieDetail: detail)
            
        }
        
    }
    
}
