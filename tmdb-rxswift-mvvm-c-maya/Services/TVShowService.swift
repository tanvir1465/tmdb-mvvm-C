//
//  TVShowService.swift
//  tmdb-rxswift-mvvm-c-maya
//
//  Created by Tanvir Hasan Piash on 13/1/21.
//

import Foundation
import RxSwift

protocol TVShowServiceProtocol {
    
    func fetchTVShows() -> Observable<TVShow>
    
    func fetchTVShowDetail(id: Int) -> Observable<TVShowDetail>
    
}

class TVShowService: TVShowServiceProtocol {
    
    lazy var apiService = APIService(config: .default)
    
    func fetchTVShows() -> Observable<TVShow> {

        return apiService.request(for: .getTVShows)

    }
    
    func fetchTVShowDetail(id: Int) -> Observable<TVShowDetail> {
        
        return apiService.request(for: .getTVShowDetails(id: id))
        
    }
    
}
