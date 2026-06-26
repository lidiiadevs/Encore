//
//  ContentView.swift
//  Encore
//
//  Created by Lidiia Diachkovskaia on 6/26/26.
//

import SwiftUI

//VM - business logic and state, no UI layout
//V - are layout and gesture only. No data fetching

struct AttendedView: View {
    @State private var shows: [Show] = []
    
    
    var body: some View {
        NavigationStack {
            List(shows) { show in
                Text(show.artistName)
            }
            .navigationTitle("Attended")
            .toolbar{
                Button("Add Show", systemImage: "plus") {
                    shows.append(Show(artistName: "Radiiohead", venueName: "Madison Square Garden", city: "New York", date: .now, status: .attended))
                }
            }
        }
    }
}

#Preview {
    AttendedView()
}
