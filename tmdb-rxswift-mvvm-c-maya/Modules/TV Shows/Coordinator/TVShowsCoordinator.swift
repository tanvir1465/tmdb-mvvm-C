//
//  TVShowsCoordinator.swift
//  tmdb-rxswift-mvvm-c-maya
//
//  Created by Tanvir Hasan Piash on 13/1/21.
//

import UIKit
import RxSwift

class TVShowsCoordinator: BaseCoordinator<Void> {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() -> Observable<Void> {
        let viewModel = TVShowListViewModel()
        let controller = TVShowsController()
        navigationController.setViewControllers([controller], animated: true)
        controller.viewModel = viewModel
        
        viewModel.showTvDetail.subscribe { [weak self] (event) in
            let detailCoordinator = TVShowsDetailCoordinator(rootViewController: controller, tvShowId: event.element?.id ?? 0)
            _ = self?.coordinate(to: detailCoordinator)
        }
        .disposed(by: disposeBag)

        
        return Observable.never()
    }
    
}
