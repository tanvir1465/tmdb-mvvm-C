//
//  SearchViewModel.swift
//  tmdb-rxswift-mvvm-c-maya
//
//  Created by Tanvir Hasan Piash on 13/1/21.
//

import Foundation

struct SearchViewModel {
    
    private let result: SearchResult
    
    var posterImage: String {
        return result.posterPath ?? ""
    }
    
    var id: Int {
        return result.id
    }
    
    var title: String {
        return result.title ?? ""
    }
    
    var name: String {
        return result.name ?? ""
    }
    
    var type: Int
    
    init(result: SearchResult, type: Int) {
        self.result = result
        self.type = type
    }
    
}
