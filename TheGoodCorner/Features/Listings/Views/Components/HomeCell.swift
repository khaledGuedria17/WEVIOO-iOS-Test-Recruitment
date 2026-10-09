//
//  HomeCell.swift
//  TheGoodCorner
//
//  Created by Khaled Guedria on 9/10/2026.
//


import SwiftUI

struct HomeCell: View {
    let listing: ListingEntity
    let categoryName: String
    var isFavorite: Bool = false

    var onTap: (() -> Void)? = nil

    private var imageURL: URL? {
        // Prefer the small image for feed performance.
        if let small =  listing.imageSmall,
           let url = URL(string: Utilities.BASE_URL + small) {
            return url
        }

        if let thumb = listing.imageThumb,
           let url = URL(string: Utilities.BASE_URL + thumb) {
            return url
        }

        return nil
    }

    private var formattedPrice: String {
        guard let price = listing.price else {
            return "Price unavailable"
        }

        return NumberFormatter.localizedString(
            from: NSNumber(value: price),
            number: .ordinal
        )
    }

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            listingImage
                .frame(width: 112, height: 132)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(alignment: .topLeading) {
                    if listing.isUrgent == true {
                        Label("URGENT", systemImage: "flame.fill")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 9)
                            .padding(.vertical, 6)
                            .background(Color.marketplaceOrange)
                            .clipShape(Capsule())
                            .padding(7)
                    }
                }

            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 6) {
                    Text(categoryName)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(Color.marketplaceSecondary)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.marketplaceChip)
                        .clipShape(Capsule())
                        .lineLimit(1)

                    
                }

                Text(listing.title ?? "Untitled listing")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(Color.marketplaceText)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Spacer(minLength: 0)

                Text(formattedPrice)
                    .font(.system(size: 21, weight: .bold))
                    .foregroundStyle(
                        listing.isUrgent == true
                        ? Color.marketplaceOrange
                        : Color.marketplaceText
                    )
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)

                Text(listing.creationDate ?? "")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(Color.marketplaceSecondary)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 132)
        }
        .padding(12)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.marketplaceBorder, lineWidth: 0.5)
        }
        .contentShape(RoundedRectangle(cornerRadius: 16))
        .onTapGesture {
            onTap?()
        }
    }

    @ViewBuilder
    private var listingImage: some View {
        if let url = imageURL {
            AsyncImage(url: url) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()

                case .empty:
                    placeholder
                        .overlay {
                            ProgressView()
                        }

                case .failure:
                    placeholder

                @unknown default:
                    placeholder
                }
            }
        } else {
            placeholder
        }
    }

    private var placeholder: some View {
        VStack(spacing: 8) {
            Image(systemName: "camera")
                .font(.system(size: 24))

            Text("Photo unavailable")
                .font(.system(size: 12, weight: .medium))
                .multilineTextAlignment(.center)
        }
        .foregroundStyle(Color.marketplaceSecondary)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.marketplacePlaceholder)
    }
}
