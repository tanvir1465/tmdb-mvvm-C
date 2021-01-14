//
//  TabCoordinator.swift
//  tmdb-rxswift-mvvm-c-maya
//
//  Created by Tanvir Hasan Piash on 13/1/21.
//

import UIKit
import RxSwift

class TabCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    private let viewControllers: [UINavigationController]
    
    init(window: UIWindow) {
        self.window = window
        self.viewControllers = Tab.items.map({ (tab) -> UINavigationController in
            let navigation = UINavigationController()
            navigation.navigationBar.prefersLargeTitles = true
            navigation.tabBarItem.title = tab.title
            navigation.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.systemPink], for: .selected)
            navigation.tabBarItem.image = UIImage(systemName: tab.icon)
            navigation.tabBarItem.selectedImage = UIImage(systemName: tab.icon)?.withTintColor(.systemPink, renderingMode: .alwaysOriginal)
            return navigation
        })
    }
    
    override func start() -> Observable<CoordinationResult> {
        let tabController = TabController()
        tabController.tabBar.isTranslucent = true
        tabController.viewControllers = viewControllers
        
        let coordinators = viewControllers.enumerated().map { (index, element) -> Observable<Void> in
            guard let tabs = Tab(rawValue: index) else { return Observable.just(()) }
            switch tabs {
            case .movies:
                return coordinate(to: MovieCoordinator(navigationController: element))
            case .shows:
                return coordinate(to: TVShowsCoordinator(navigationController: element))
            case .search:
                return coordinate(to: SearchCoordinator(navigationController: element))
            }
        }
        
        Observable.merge(coordinators).subscribe().disposed(by: disposeBag)
        
        window.rootViewController = tabController
        window.makeKeyAndVisible()
        return Observable.never()
    }
    
}
