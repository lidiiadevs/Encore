//
//  Show.swift
//  Encore
//
//  Created by Lidiia Diachkovskaia on 6/26/26.
//

import Foundation

enum ShowStatus {
    case attended
    case upcoming
}

struct Show: Identifiable {
    var artistName: String
    var venueName: String
    var city: String
    var date: Date
    var status: ShowStatus
    
    let id = UUID()
}
