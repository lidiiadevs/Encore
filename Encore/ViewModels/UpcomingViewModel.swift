//
//  UpcomingViewModel.swift
//  Encore
//
//  Created by Lidiia Diachkovskaia on 7/2/26.
//

import Foundation
import SwiftData

@Observable
final class UpcomingViewModel {
    var showingAddSheet = false
    var showToMarkAttended: Show? //nil means closed and show means open and right after goes rating
    var pendingRating = 0
    
    func filteresShows(_ shows: [Show]) -> [Show] {
        shows.filter { $0.status == .upcoming }
            .sorted { $0.date < $1.date }
    }
    
    func delete(_ show: Show, context: ModelContext) {
        context.delete(show)
    }
    
    func markAsAttended(_ show: Show) {
        show.status = .attended
        show.rating = pendingRating > 0 ? pendingRating : nil
        pendingRating = 0 //default
        showToMarkAttended = nil //cleening the state for the next interaction
    }
}
