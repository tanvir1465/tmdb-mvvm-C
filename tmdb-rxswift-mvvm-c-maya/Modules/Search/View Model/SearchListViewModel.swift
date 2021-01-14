//
//  SearchListViewModel.swift
//  tmdb-rxswift-mvvm-c-maya
//
//  Created by Tanvir Hasan Piash on 13/1/21.
//

import Foundation
import RxSwift
import RxCocoa

enum SearchError: Error {
    case error(Error)
    case notFound
    case undefined
}

final class SearchListViewModel {
    
    private let disposeBag = DisposeBag()
    
    let selectSearchItem: AnyObserver<SearchViewModel>
    
    let showDetail: Observable<SearchViewModel>
    
    private let searchSubject = PublishSubject<String>()
    var searchObserver: AnyObserver<String> {
        return searchSubject.asObserver()
    }
    
    private let scopeSubject = PublishSubject<Int>()
    var scopeObserver: AnyObserver<Int> {
        return scopeSubject.asObserver()
    }
    
    private let loadingSubject = PublishSubject<Bool>()
    var isLoading: Driver<Bool> {
        return loadingSubject.asDriver(onErrorJustReturn: false)
    }
    
    private let errorSubject = PublishSubject<SearchError?>()
    var error: Driver<SearchError?> {
        return errorSubject.asDriver(onErrorJustReturn: .undefined)
    }
    
    private let contentSubject = PublishSubject<[SearchViewModel]>()
    var content: Driver<[SearchViewModel]> {
        return contentSubject
            .asDriver(onErrorJustReturn: [])
    }
    
    private let searchService: SearchServiceProtocol
    
    init(searchService: SearchServiceProtocol = SearchService()) {
        
        self.searchService = searchService
        
        let _selectSearchItem = PublishSubject<SearchViewModel>()
        self.selectSearchItem = _selectSearchItem.asObserver()
        self.showDetail = _selectSearchItem.asObservable()
        
        Observable.combineLatest(searchSubject.asObservable(), scopeSubject.asObservable()) { ($0, $1) }
            .filter({ !$0.0.isEmpty })
            .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .flatMapLatest { [unowned self] (query, scope) -> Observable<[SearchViewModel]> in
                self.errorSubject.onNext(nil)
                self.loadingSubject.onNext(true)
                return self.fetchSearchViewModel(query: query, scope: scope)
            }
            .subscribe { [unowned self] (result) in
                self.loadingSubject.onNext(false)
                guard let elements = result.element else {
                    self.errorSubject.onNext(.notFound)
                    return
                }
                self.contentSubject.onNext(elements)
            }
            .disposed(by: disposeBag)

        
    }
    
    private func fetchSearchViewModel(query: String, scope: Int) -> Observable<[SearchViewModel]> {
        
        searchService.search(query: query, scope: scope).map {
            
            return $0.results.map { (result) in
                
                SearchViewModel.init(result: result, type: scope)
                
            }
            
        }
        
    }
    
}
