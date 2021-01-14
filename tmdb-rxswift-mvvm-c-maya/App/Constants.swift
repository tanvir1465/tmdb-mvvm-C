//
//  Constants.swift
//  tmdb-rxswift-mvvm-c-maya
//
//  Created by Tanvir Hasan Piash on 13/1/21.
//

import Foundation

struct Constants {
    
    static let apiKey = "eb8aa6f914f794f711fb1841fb141f12"
    
    static let baseUrl = "api.themoviedb.org"
    
    static let imageBasePath = "http://image.tmdb.org/t/p"
    
    struct Parameters {
        static let apiKey = "api_key"
        static let search = "query"
    }
    
    enum HttpHeaderField: String {
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    enum ContentType: String {
        case json = "application/json"
    }
    
}
