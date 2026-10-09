//
//  HomeViewModel.swift
//  TheGoodCorner
//
//  Created by Khaled Guedria on 9/10/2026.
//


import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {

    // MARK: - Published state

    @Published private(set) var categories: [CategoryEntity] = []
    @Published private(set) var listings: [ListingEntity] = []

    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    @Published var searchText = ""
    @Published var selectedCategoryId: Int?
    @Published var sortOption: ListingSortOption = .defaultOrder

    // MARK: - Dependencies

    private let categoryRepository: CategoryRepository
    private let listingRepository: ListingRepository

    // MARK: - Initialization

    init(
        categoryRepository: CategoryRepository,
        listingRepository: ListingRepository) {
        self.categoryRepository = categoryRepository
        self.listingRepository = listingRepository
    }

    // MARK: - Derived data

    var filteredListings: [ListingEntity] {
        var result = listings.filter { listing in
            let query = searchText.trimmingCharacters(
                in: .whitespacesAndNewlines
            )

            let matchesSearch =
                query.isEmpty ||
                (listing.title ?? "")
                    .localizedCaseInsensitiveContains(query) ||
                (listing.description ?? "")
                    .localizedCaseInsensitiveContains(query)

            let matchesCategory =
                selectedCategoryId == nil ||
                listing.categoryId == selectedCategoryId

            return matchesSearch && matchesCategory
        }

        switch sortOption {
        case .defaultOrder:
            // Preserve the order returned by the API.
            break

        case .priceAscending:
            result.sort {
                ($0.price ?? Int.max) < ($1.price ?? Int.max)
            }

        case .priceDescending:
            result.sort {
                ($0.price ?? Int.min) > ($1.price ?? Int.min)
            }

        case .urgentFirst:
            result.sort {
                ($0.isUrgent ?? false) &&
                !($1.isUrgent ?? false)
            }
        }

        return result
    }

    func categoryName(for categoryId: Int) -> String {
        categories.first { $0.id == categoryId }?.name ?? "Other"
    }

    // MARK: - Loading

    func loadHome() async {
        
        guard !isLoading else { return }

        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        do {
            async let fetchedCategories =
            categoryRepository.getCategories(data: CategoryService().fetch())

            async let fetchedListings =
            listingRepository.getListings(data: ListingService().fetch())

            let (newCategories, newListings) = try await (
                fetchedCategories,
                fetchedListings
            )
            categories = newCategories
            listings = newListings

        } catch {
            errorMessage = error.localizedDescription
        }
    }

    // MARK: - Actions

    func selectCategory(_ categoryId: Int?) {
        selectedCategoryId = categoryId
    }

    func updateSearch(_ text: String) {
        searchText = text
    }

    func updateSort(_ option: ListingSortOption) {
        sortOption = option
    }
}

enum ListingSortOption: String, CaseIterable, Identifiable {
    case defaultOrder = "Default"
    case priceAscending = "Price: Low to High"
    case priceDescending = "Price: High to Low"
    case urgentFirst = "Urgent First"

    var id: String { rawValue }
}
