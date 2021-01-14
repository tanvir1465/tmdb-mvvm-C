//
//  Tab.swift
//  tmdb-rxswift-mvvm-c-maya
//
//  Created by Tanvir Hasan Piash on 13/1/21.
//

import Foundation
import UIKit

enum Tab: Int {
    
    case movies
    case shows
    case search
    
    var title: String {
        switch self {
        case .movies:
            return "Movies"
        case .shows:
            return "TV Shows"
        case .search:
            return "Search"
        }
    }
    
    var icon: String {
        switch self {
        case .movies:
            return "play.rectangle"
        case .shows:
            return "tv"
        case .search:
            return "magnifyingglass"
        }
    }
    
}
