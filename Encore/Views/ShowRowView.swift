//
//  ShowRowView.swift
//  Encore
//
//  Created by Lidiia Diachkovskaia on 7/1/26.
//

import SwiftUI
import SwiftData

struct ShowRowView: View {
    let show: Show
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(show.artistName)
                .font(.headline)
            HStack(spacing: 4) {
                Text(show.venueName)
                Text("-")
                Text(show.city)
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
            
            HStack {
                Text(show.date.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
                    .foregroundStyle(.secondary)
                if let rating = show.rating {
                    Spacer()
                    HStack(spacing: 2) {
                        ForEach(1...5, id: \.self) { star in
                            Image(systemName: star <= rating ? "star.fill" : "star")
                                .font(.caption2)
                                .foregroundStyle(star <= rating ? Color.yellow : Color.secondary)
                        }
                    }
                }
            }
        }
        .padding(.vertical, 2)
    }
}
//
//#Preview("Rated Row") {
//    let config = ModelConfiguration(isStoredInMemoryOnly: true)
//    let container = try? ModelContainer(for: Show.self, configurations: config)
//    
//    let mgk = Show(artistName: "mgk", venueName: "mmm", city: "mm", date: .now, status: .attended)
//    
//    mgk.rating = 4
//    container.mainContext.insert(mgk)
//    
//    return ShowRowView(show: mgk)
//        .padding()
//        .modelContainer(container)
//        .previewLayout(.sizeThatFits)
//}
