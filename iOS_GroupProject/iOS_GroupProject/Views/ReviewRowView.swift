//
//  ReviewRowView.swift
//  iOS_GroupProject
//
//  Created by Bùi Thiên on 22/09/2023.
//

import SwiftUI

struct ReviewRowView: View {
    var review: Review

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Rating: \(review.rating)")
                .font(.headline)
            Text(review.content ?? "")
                .font(.body)
                .lineLimit(nil) // Show full review content
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .padding(.vertical, 8)
    }
}
