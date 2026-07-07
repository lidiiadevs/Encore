//
//  ShowDetailView.swift
//  Encore
//
//  Created by Lidiia Diachkovskaia on 7/7/26.
//

import SwiftUI
import SwiftData

struct ShowDetailView: View {
    @Bindable var show : Show
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var showingEditSheet = false
    @State private var showingDeleteAlert = false
    @State private var newSetlistEntry = ""
    
    var body: some View {
        List {
            Section("Show Info") {
                LabeledContent("Artist", value: show.artistName) // LabeledContennt is available in iOS 17
                LabeledContent("Venue", value: show.venueName)
                LabeledContent("City", value: show.city)
                LabeledContent("Date", value: show.date.formatted(date: .long, time: .omitted))
                LabeledContent("Status", value: show.status.rawValue.capitalized) //bc we use enum its rawValue - String
            }
            if show.status == .attended {
                Section("Rating") {
                    StarRatingView(rating: Binding(get: { show.rating ?? 0 },
                                                   set: { show.rating = $0 > 0 ? $0 : nil }))
                    //because rating is optional we use get and set
                }
            }
        }
    }
}

#Preview {
    ShowDetailView(show: Show(artistName: "dfg", venueName: "sgffg", city: "sgf", date: Date(), status: .attended))
}
