//
//  APIError.swift
//  tmdb-rxswift-mvvm-c-maya
//
//  Created by Tanvir Hasan Piash on 13/1/21.
//

import Foundation

enum APIError: Error {
    case forbidden // 403
    case notFound // 404
    case conflict // 409
    case internalServerError // 500
}
