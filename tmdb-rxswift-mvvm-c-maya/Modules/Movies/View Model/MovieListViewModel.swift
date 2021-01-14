//
//  MovieListViewModel.swift
//  tmdb-rxswift-mvvm-c-maya
//
//  Created by Tanvir Hasan Piash on 13/1/21.
//

import Foundation
import RxSwift
import RxCocoa

final class MovieListViewModel {
    
    let title = "Movies"
    
    let selectMovie: AnyObserver<MovieViewModel>
    
    let showMovieDetail: Observable<MovieViewModel>
    
    private let movieService: MovieServiceProtocol
    
    init(movieService: MovieServiceProtocol = MovieService()) {
        
        self.movieService = movieService
        
        let _selectMovie = PublishSubject<MovieViewModel>()
        self.selectMovie = _selectMovie.asObserver()
        self.showMovieDetail = _selectMovie.asObservable()
        
    }
    
    func fetchMovieViewModel() -> Observable<[MovieViewModel]> {
        
        movieService.fetchMovies().map {
            
            $0.results.map { (movie)  in
                
                MovieViewModel.init(movie: movie)
                
            }
            
        }
        
    }
    
}
