//
//  CategoriesView.swift
//  TheGoodCorner
//
//  Created by Khaled Guedria on 9/10/2026.
//



import SwiftUI

struct CategoriesView: View {
    let categories: [CategoryEntity]

    @Binding var selectedCategoryId: Int?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                categoryChip(
                    title: "All Categories",
                    systemImage: "square.grid.3x3.fill",
                    isSelected: selectedCategoryId == nil
                ) {
                    selectedCategoryId = nil
                }

                ForEach(
                    Array(categories.enumerated()),
                    id: \.offset
                ) { _, category in
                    categoryChip(
                        title: category.name ?? "Category",
                        systemImage: icon(for: category.name),
                        isSelected: category.id == selectedCategoryId
                    ) {
                        selectedCategoryId = category.id
                    }
                    .disabled(category.id == nil)
                }
            }
            .padding(.vertical, 2)
        }
    }

    private func categoryChip(
        title: String,
        systemImage: String,
        isSelected: Bool,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            HStack(spacing: 9) {
                Image(systemName: systemImage)

                Text(title)
                    .fixedSize()
            }
            .font(.system(size: 15, weight: .semibold))
            .foregroundStyle(
                isSelected
                ? Color.white
                : Color.marketplaceSecondary
            )
            .padding(.horizontal, 17)
            .frame(height: 48)
            .background {
                Capsule()
                    .fill(
                        isSelected
                        ? Color.marketplaceNavy
                        : Color.white
                    )
            }
            .overlay {
                Capsule()
                    .stroke(
                        isSelected
                        ? Color.clear
                        : Color.marketplaceBorder,
                        lineWidth: 0.7
                    )
            }
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

    private func icon(for name: String?) -> String {
        switch name?.lowercased() {
        case "vehicles": return "car.fill"
        case "real estate": return "building.2.fill"
        case "electronics": return "desktopcomputer"
        case "home & garden": return "leaf.fill"
        case "sports & leisure": return "bicycle"
        default: return "square.grid.2x2.fill"
        }
    }
}
