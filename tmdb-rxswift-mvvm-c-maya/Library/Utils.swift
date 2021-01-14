//
//  Utils.swift
//  tmdb-rxswift-mvvm-c-maya
//
//  Created by Tanvir Hasan Piash on 13/1/21.
//

import UIKit

extension Int {
    
    var toFormattedRuntime: String {
        let hourComponent = self / 60
        let minuteComponent = self % 60
        return "\(hourComponent)h \(minuteComponent)m"
    }
    
}




