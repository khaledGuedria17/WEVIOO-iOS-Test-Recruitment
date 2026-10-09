//
//  SearchView.swift
//  TheGoodCorner
//
//  Created by Khaled Guedria on 9/10/2026.
//


import SwiftUI

struct SearchView: View {
    @Binding var searchText: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(Color.marketplaceSecondary)

            TextField("Search listings...", text: $searchText)
                .font(.system(size: 16))
                .foregroundStyle(Color.marketplaceText)
                .submitLabel(.search)
                .accessibilityLabel("Search listings")

            if !searchText.isEmpty {
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Clear search")
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 52)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.marketplaceBorder, lineWidth: 0.7)
        }
    }
}
