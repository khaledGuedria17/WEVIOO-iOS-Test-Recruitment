//
//  ListingDetailsView.swift
//  TheGoodCorner
//
//  Created by Khaled Guedria on 10/10/2026.
//

import SwiftUI

struct ListingDetailsView: View {
    let listing: ListingEntity

    private let accentColor = Color(
        red: 1.0,
        green: 0.31,
        blue: 0.10
    )

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {

                // Listing image
                listingImage

                // Category (not available in your current attributes)
                // Add this section when category data is available.

                // Price
                HStack(alignment: .center) {
                    Text(priceText)
                        .font(.system(size: 28, weight: .bold))

                    Spacer()

                    Text("Fixed Price")
                        .font(.caption.weight(.medium))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.indigo.opacity(0.10))
                        .clipShape(Capsule())
                }

                // Title
                Text(listing.title ?? "Untitled listing")
                    .font(.system(size: 20, weight: .bold))
                    .fixedSize(horizontal: false, vertical: true)

                // Creation date
                HStack(spacing: 6) {
                    Image(systemName: "clock")
                    Text(publicationDate)
                    Text("·")
                }
                .font(.caption)
                .foregroundStyle(.secondary)

                // Description card
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 10) {
                        Image(systemName: "doc.text")
                            .foregroundStyle(accentColor)

                        Text("Description")
                            .font(.headline)
                    }

                    Text(
                        listing.description
                            ?? "No description provided."
                    )
                    .font(.system(size: 15))
                    .lineSpacing(5)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.indigo.opacity(0.055))
                .clipShape(RoundedRectangle(cornerRadius: 28))
                .padding(.top, 28)
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .padding(.bottom, 24)
        }
        .background(Color(uiColor: .systemBackground))
        .navigationTitle("Listing Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        
    }

    // MARK: - Image

    private var listingImage: some View {
        ZStack(alignment: .topLeading) {
            Group {
                if let urlString = listing.imageThumb,
                   let url = URL(string: Utilities.BASE_URL + urlString) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        imagePlaceholder
                    }
                } else {
                    imagePlaceholder
                }
            }
            .frame(height: 250)
            .frame(maxWidth: .infinity)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 28))

            if listing.isUrgent == true {
                Label("URGENT LISTING", systemImage: "bolt.fill")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(accentColor)
                    .clipShape(Capsule())
                    .padding(12)
            }
        }
    }

    private var imagePlaceholder: some View {
        RoundedRectangle(cornerRadius: 28)
            .fill(Color.gray.opacity(0.15))
            .overlay {
                Image(systemName: "photo")
                    .font(.largeTitle)
                    .foregroundStyle(.secondary)
            }
    }

    // MARK: - Formatting

    private var priceText: String {
        guard let price = listing.price else {
            return "Price unavailable"
        }

        return price.formatted(
            .currency(code: "EUR").locale(Locale(identifier: "fr_FR"))
        )
    }

    private var publicationDate: String {
        guard let dateString = listing.creationDate,
              !dateString.isEmpty else {
            return "Publication date unavailable"
        }
        
        let isoFormatter = ISO8601DateFormatter()

            guard let date = isoFormatter.date(from: dateString) else {
                return dateString
            }

            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = "yyyy-MM-dd HH'H'mm"

            return "Pulished At : \(formatter.string(from: date))"
    }

}
