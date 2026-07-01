//
//  AttendedViewModel.swift
//  Encore
//
//  Created by Lidiia Diachkovskaia on 6/26/26.
//

import Foundation
import SwiftData

//VM's job is to hold a state that belongs to a screen, not a state that belongs to a view - that's the distinction
@Observable
final class AttendedViewModel {
    var searchText = ""
    var showingAddSheet = false
    
    func filteredShows(_ shows: [Show]) -> [Show] { //it filter whatever was handed - that is a separation
        let attended = shows.filter({ $0.status == .attended})
        guard !searchText.isEmpty else { return attended }
        return attended.filter {
            $0.artistName.localizedCaseInsensitiveContains(searchText) ||
            $0.venueName.localizedCaseInsensitiveContains(searchText) ||
            $0.city.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    func delete(_ show: Show, context: ModelContext) {
            context.delete(show)
        }
}

