//
//  MovieDetailCoordinator.swift
//  tmdb-rxswift-mvvm-c-maya
//
//  Created by Tanvir Hasan Piash on 13/1/21.
//

import UIKit
import RxSwift

class MovieDetailCoordinator: BaseCoordinator<Void> {
    
    private let rootViewController: UIViewController
    
    private let movieId: Int
    
    init(rootViewController: UIViewController, movieId: Int) {
        self.rootViewController = rootViewController
        self.movieId = movieId
    }
    
    override func start() -> Observable<Void> {
        
        let viewModel = MovieDetailViewModel()
        let controller = MovieDetailController()
        controller.movieId = self.movieId
        controller.viewModel = viewModel
        rootViewController.present(controller, animated: true)
        
        return Observable.never()
        
    }
    
}
