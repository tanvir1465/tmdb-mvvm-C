//
//  TVShowsDetailCoordinator.swift
//  tmdb-rxswift-mvvm-c-maya
//
//  Created by Tanvir Hasan Piash on 14/1/21.
//

import UIKit
import RxSwift

class TVShowsDetailCoordinator: BaseCoordinator<Void> {
    
    private let rootViewController: UIViewController
    
    private let tvShowId: Int
    
    init(rootViewController: UIViewController, tvShowId: Int) {
        self.rootViewController = rootViewController
        self.tvShowId = tvShowId
    }
    
    override func start() -> Observable<Void> {
        
        let viewModel = TVShowDetailViewModel()
        let controller = TVShowsDetailController()
        controller.tvShowId = self.tvShowId
        controller.viewModel = viewModel
        rootViewController.present(controller, animated: true)
        
        return Observable.never()
        
    }
    
}
