//
//  MovieCoordinator.swift
//  tmdb-rxswift-mvvm-c-maya
//
//  Created by Tanvir Hasan Piash on 13/1/21.
//

import UIKit
import RxSwift

class MovieCoordinator: BaseCoordinator<Void> {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() -> Observable<Void> {
        let viewModel = MovieListViewModel()
        let controller = MovieController()
        navigationController.setViewControllers([controller], animated: true)
        controller.viewModel = viewModel
        
        viewModel.showMovieDetail.subscribe { [weak self] (event) in
            let detailCoordinator = MovieDetailCoordinator(rootViewController: controller, movieId: event.element?.id ?? 0)
            _ = self?.coordinate(to: detailCoordinator)
        }
        .disposed(by: disposeBag)


        return Observable.never()
    }
    
}
