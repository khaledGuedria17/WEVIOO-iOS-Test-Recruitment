import SwiftUI

@main
struct TheGoodCornerApp: App {
    var body: some Scene {
            WindowGroup {
                HomeView(
                    viewModel: HomeViewModel(
                        categoryRepository: CategoryRepository(),
                        listingRepository: ListingRepository()
                    )
                )
            }
        }

}
