//
//  EmptyStateView.swift
//  Encore
//
//  Created by Lidiia Diachkovskaia on 7/9/26.
//

import SwiftUI

struct EmptyStateView: View {
    let icon: String
    let title: String
    let message: String
    
    var body: some View {
        ContentUnavailableView(title, systemImage: icon, description: Text(message))
    }
}


