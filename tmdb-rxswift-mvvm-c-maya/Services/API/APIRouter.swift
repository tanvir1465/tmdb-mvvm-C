//
//  APIRouter.swift
//  tmdb-rxswift-mvvm-c-maya
//
//  Created by Tanvir Hasan Piash on 13/1/21.
//

import Foundation

enum APIRouter {
    
    case getMovies
    case getTVShows
    case getMovieDetails(id: Int)
    case getTVShowDetails(id: Int)
    case searchMovie(query: String)
    case searchTVShow(query: String)
    
}

extension APIRouter {
    
    var scheme: String {
        
        switch self {
        default:
            return "https"
        }
        
    }
    
    var host: String {
        
        switch self {
        default:
            return Constants.baseUrl
        }
        
    }
    
    var path: String {
        
        switch self {
        case .getMovies:
            return "/3/discover/movie"
        case .getTVShows:
            return "/3/discover/tv"
        case .getMovieDetails(let movieId):
            return "/3/movie/\(movieId)"
        case .getTVShowDetails(let tvShowId):
            return "/3/tv/\(tvShowId)"
        case .searchMovie:
            return "/3/search/movie"
        case .searchTVShow:
            return "/3/search/tv"
        }
        
    }
    
    var method: String {
        
        switch self {
        default:
            return "GET"
        }
        
    }
    
    var parameters: [URLQueryItem] {
        
        switch self {
        case .getMovies, .getTVShows, .getMovieDetails, .getTVShowDetails:
            return [
                URLQueryItem(name: Constants.Parameters.apiKey, value: Constants.apiKey)
            ]
        case .searchMovie(let query), .searchTVShow(let query):
            return [
                URLQueryItem(name: Constants.Parameters.apiKey, value: Constants.apiKey),
                URLQueryItem(name: Constants.Parameters.search, value: query)
            ]
        }
        
    }
    
}
