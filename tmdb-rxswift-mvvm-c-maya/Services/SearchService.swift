//
//  SearchService.swift
//  tmdb-rxswift-mvvm-c-maya
//
//  Created by Tanvir Hasan Piash on 13/1/21.
//

import Foundation
import RxSwift

protocol SearchServiceProtocol {
    
    func search(query: String, scope: Int) -> Observable<Search>
    
}

class SearchService: SearchServiceProtocol {
    
    lazy var apiService = APIService(config: .default)
    
    func search(query: String, scope: Int) -> Observable<Search> {
        
        switch scope {
        
        case 0:
            return apiService.request(for: .searchMovie(query: query))
            
        case 1:
            return apiService.request(for: .searchTVShow(query: query))
            
        default:
            return .empty()
            
        }
        
    }
    
}
