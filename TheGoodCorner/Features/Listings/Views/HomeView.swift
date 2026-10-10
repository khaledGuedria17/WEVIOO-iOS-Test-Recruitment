//
//  HomeView.swift
//  TheGoodCorner
//
//  Created by Khaled Guedria on 9/10/2026.
//


import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    @State private var selectedListing: ListingEntity?
    @State private var showDetails = false

    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    header
                    
                    SearchView(searchText: $viewModel.searchText)
                    
                    CategoriesView(
                        categories: viewModel.categories,
                        selectedCategoryId: $viewModel.selectedCategoryId
                    )
                    
                    feedHeader
                    
                    if viewModel.isLoading && viewModel.listings.isEmpty {
                        ProgressView("Loading listings...")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 40)
                        
                    } else if let error = viewModel.errorMessage,
                              viewModel.listings.isEmpty {
                        errorView(error)
                        
                    } else if viewModel.filteredListings.isEmpty {
                        if #available(iOS 17.0, *) {
                            ContentUnavailableView(
                                "No listings found",
                                systemImage: "magnifyingglass",
                                description: Text(
                                    "Try another search or category."
                                )
                            )
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 30)
                        } else {
                            // Fallback on earlier versions
                        }
                        
                    } else {
                        listingFeed
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 24)
            }
            .background(
                Color.marketplaceBackground.ignoresSafeArea()
            )
            .task {
                await viewModel.loadHome()
            }
        }
    }

    private var header: some View {
        Text("Welcome back 👋")
            .font(.system(size: 29, weight: .heavy))
            .foregroundStyle(Color.marketplaceText)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 8)
    }

    private var feedHeader: some View {
        HStack(spacing: 10) {
            Text("Feed Stream")
                .font(.system(size: 13, weight: .bold))
                .foregroundStyle(Color.marketplaceSecondary)

            Text("\(viewModel.filteredListings.count) Active")
                .font(.system(size: 12, weight: .bold))
                .foregroundStyle(Color.marketplaceOnOrange)
                .padding(.horizontal, 11)
                .padding(.vertical, 6)
                .background(Color.marketplaceUrgentBackground)
                .clipShape(Capsule())

            Spacer(minLength: 4)

            Menu {
                ForEach(ListingSortOption.allCases) { option in
                    Button {
                        viewModel.updateSort(option)
                    } label: {
                        if viewModel.sortOption == option {
                            Label(option.rawValue, systemImage: "checkmark")
                        } else {
                            Text(option.rawValue)
                        }
                    }
                }
            } label: {
                Label(
                    viewModel.sortOption.rawValue,
                    systemImage: "arrow.up.arrow.down"
                )
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(Color.marketplaceText)
                .padding(.horizontal, 12)
                .padding(.vertical, 9)
                .background(Color.marketplaceChip)
                .clipShape(Capsule())
            }
        }
    }

    private var listingFeed: some View {
        LazyVStack(spacing: 14) {
            ForEach(
                Array(viewModel.filteredListings.enumerated()),
                id: \.offset
            ) { _, listing in
                HomeCell(
                    listing: listing,
                    categoryName: viewModel.categoryName(
                        for: listing.categoryId
                    ),
                    onTap: {
                        selectedListing = listing
                        showDetails = true

                    }
                )
            }
        }
        .navigationDestination(isPresented: $showDetails) {
                if let listing = selectedListing {
                    ListingDetailsView(listing: listing)
                }
            }
    }

    private func errorView(_ message: String) -> some View {
        VStack(spacing: 12) {
            Image(systemName: "wifi.exclamationmark")
                .font(.system(size: 32))
                .foregroundStyle(Color.marketplaceSecondary)

            Text(message)
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.marketplaceSecondary)

            Button("Try again") {
                Task {
                    await viewModel.loadHome()
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(Color.marketplaceOrange)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
    }
}
