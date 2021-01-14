//
//  MovieService.swift
//  tmdb-rxswift-mvvm-c-maya
//
//  Created by Tanvir Hasan Piash on 13/1/21.
//

import Foundation
import RxSwift

protocol MovieServiceProtocol {
    
    func fetchMovies() -> Observable<Movie>
    
    func fetchMovieDetails(id: Int) -> Observable<MovieDetail>
    
}

class MovieService: MovieServiceProtocol {
    
    lazy var apiService = APIService(config: .default)
    
    func fetchMovies() -> Observable<Movie> {

        return apiService.request(for: .getMovies)

    }
    
    func fetchMovieDetails(id: Int) -> Observable<MovieDetail> {
        
        return apiService.request(for: .getMovieDetails(id: id))
        
    }
    
}
