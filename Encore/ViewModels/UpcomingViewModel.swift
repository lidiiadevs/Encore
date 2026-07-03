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
    
    func filteresShows(_ shows: [Show]) -> [Show] {
        shows.filter { $0.status == .upcoming }
            .sorted { $0.date < $1.date }
    }
    
    func delete(_ show: Show, context: ModelContext) {
        context.delete(show)
    }
}
