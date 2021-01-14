//
//  TVShowDetailViewModel.swift
//  tmdb-rxswift-mvvm-c-maya
//
//  Created by Tanvir Hasan Piash on 13/1/21.
//

import Foundation
import RxSwift

final class TVShowDetailViewModel {
    
    private let tvShowService: TVShowServiceProtocol
    
    init(tvShowService: TVShowServiceProtocol = TVShowService()) {
        
        self.tvShowService = tvShowService
        
    }
    
    func fetchTVShowDetailModel(id: Int) -> Observable<TVShowDetailModel> {
        
        tvShowService.fetchTVShowDetail(id: id).map { (detail) in
            
            TVShowDetailModel.init(tvShowDetail: detail)
            
        }
        
    }
    
}
