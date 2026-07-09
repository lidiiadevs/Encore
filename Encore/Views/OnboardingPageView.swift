//
//  OnboardingPageView.swift
//  Encore
//
//  Created by Lidiia Diachkovskaia on 7/8/26.
//

import SwiftUI

struct OnboardingPageView: View {
    let icon: String
    let color: Color
    let title: String
    let description: String
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Image(systemName: icon)
                .font(.system(size: 90))
                .foregroundStyle(color)
            Text(title)
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
            Text(description)
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            Spacer()
            Spacer()
        }
        .padding()
    }
}

#Preview {
    OnboardingPageView(icon: "plus", color: .yellow, title: "tifkjfsl ", description: "aklfjl")
}
