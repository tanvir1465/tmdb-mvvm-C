//
//  TVShowListViewModel.swift
//  tmdb-rxswift-mvvm-c-maya
//
//  Created by Tanvir Hasan Piash on 13/1/21.
//

import Foundation
import RxSwift

final class TVShowListViewModel {
    
    let title = "TV Shows"
    
    let selectShow: AnyObserver<TVShowViewModel>
    
    let showTvDetail: Observable<TVShowViewModel>
    
    private let tvShowService: TVShowServiceProtocol
    
    init(tvShowService: TVShowServiceProtocol = TVShowService()) {
        
        self.tvShowService = tvShowService
        
        let _selectShow = PublishSubject<TVShowViewModel>()
        self.selectShow = _selectShow.asObserver()
        self.showTvDetail = _selectShow.asObservable()
        
    }
    
    func fetchTVShowViewModel() -> Observable<[TVShowViewModel]> {
        
        tvShowService.fetchTVShows().map {
            
            $0.results.map { (show)  in
                
                TVShowViewModel.init(tvShow: show)
                
            }
            
        }
        
    }
    
}
