//
//  BaseCoordinator.swift
//  tmdb-rxswift-mvvm-c-maya
//
//  Created by Tanvir Hasan Piash on 13/1/21.
//

import Foundation
import RxSwift

class BaseCoordinator<ResultType> {
    
    // Typealias which will allows to access a ResultType of the Coordainator by `CoordinatorName.CoordinationResult`.
    typealias CoordinationResult = ResultType
    // Utility `DisposeBag` used by the subclasses.
    let disposeBag = DisposeBag()
    // Unique identifier
    private let identifier = UUID()
    // Dictionary of child coordinators
    private var childCoordinators = [UUID: Any]()
    // Stores coordinators to coordinator dictionary
    private func store<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = coordinator
    }
    // Release coordinator from coordinator dictionary
    private func free<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = nil
    }
    // Coordinate returning an observable
    func coordinate<T>(to coordinator: BaseCoordinator<T>) -> Observable<T> {
        store(coordinator: coordinator)
        return coordinator.start().do { [weak self] (_) in
            self?.free(coordinator: coordinator)
        }
        
    }
    // Starts the job of the coordinator
    func start() -> Observable<ResultType> {
        fatalError("Must implement start method for a coordinator to work")
    }
    
    deinit {
        print(self)
    }
    
}
