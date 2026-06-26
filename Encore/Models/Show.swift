//
//  Show.swift
//  Encore
//
//  Created by Lidiia Diachkovskaia on 6/26/26.
//

import Foundation
import SwiftData

enum ShowStatus: String, Codable, CaseIterable {
    case attended
    case upcoming
}

@Model
final class Show {
    var artistName: String
    var venueName: String
    var city: String
    var date: Date
    var status: ShowStatus
    var rating: Int?
    var notes: String?
    var setlist: [String]
    var createdAt: Date
    
    init(artistName: String, venueName: String, city: String, date: Date, status: ShowStatus) {
        self.artistName = artistName
        self.venueName = venueName
        self.city = city
        self.date = date
        self.status = status
        self.rating = nil
        self.notes = nil
        self.setlist = []
        self.createdAt = .now
    }
}
