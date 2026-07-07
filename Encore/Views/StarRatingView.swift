//
//  StarRatingView.swift
//  Encore
//
//  Created by Lidiia Diachkovskaia on 7/7/26.
//

import SwiftUI

struct StarRatingView: View {
    @Binding var rating: Int
    private let maxRating = 5
    
    var body: some View {
        HStack {
            ForEach(1...maxRating, id: \.self) { star in
                Button {
                    withAnimation(.spring(response: 0.5)) {
                        rating = rating == star ? 0 : star //0 - clears the rating
                    }
                }
                label : {
                    Image(systemName: star <= rating ? "star.fill" : "star" )
                        .font(.title2)
                        .foregroundStyle(star <= rating ? .yellow : .secondary)
                        .scaleEffect(star <= rating ? 1.1 : 1.0)
                        .animation(.spring(response: 0.5), value: rating)
                }
                .buttonStyle(.plain) //prevents the tapable area from expending to fill the whole list row
            }
        }
    }
}

#Preview {
    StarRatingView(rating: .constant(3))
}
