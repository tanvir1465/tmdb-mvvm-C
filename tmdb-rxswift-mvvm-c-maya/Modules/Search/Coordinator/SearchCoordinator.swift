//
//  SearchCoordinator.swift
//  tmdb-rxswift-mvvm-c-maya
//
//  Created by Tanvir Hasan Piash on 13/1/21.
//

import UIKit
import RxSwift

class SearchCoordinator: BaseCoordinator<Void> {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() -> Observable<Void> {
        let viewModel = SearchListViewModel()
        let controller = SearchController()
        controller.viewModel = viewModel
        navigationController.setViewControllers([controller], animated: true)
        
        return Observable.never()
    }
    
}
