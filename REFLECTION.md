# iOS Technical Test — Reflection

## 1. Implementation Overview

### Summary

iOS app that displays listings and categories from the local API server.

- **Language:** Swift
- **UI Framework:** SwiftUI
- **Minimum iOS Version:** iOS 16+
- **Architecture:** MVVM (feature-first packages)
- **Networking:** URLSession with a dedicated API client
- **Testing:** XCTest

### Implemented Features

- Listings feed
- Listing details screen
- Category filtering
- Loading, error, and empty states
- Missing image and image loading failure handling
- Tests: unit and integration
- Bonus feature: search

---

## 2. Architecture and Technical Decisions

### Architecture

I chose **MVVM (Model-View-ViewModel)** because it provides a good balance between simplicity, maintainability, and testability for an application of this size. Given the one-week delivery timeframe, it allowed me to separate UI responsibilities from business logic without introducing unnecessary architectural complexity. This approach keeps the codebase easy to understand, test, and extend if new features are required.

### Networking and Data Flow

Data flows through several layers to separate networking concerns from data transformation and presentation:

1. **Service layer**: uses `URLSession` to perform HTTP requests and returns the response data along with the `HTTPURLResponse`.
2. **Repository layer**: handles response validation and JSON decoding into DTOs.
3. **Mapper**: transforms DTOs into domain entities, keeping the application model independent of the API response structure.
4. **ViewModel**: consumes these entities and exposes the necessary state to the SwiftUI views for display.

**Dependency injection** is used to provide dependencies to the components that need them, reducing coupling and making the application easier to test. In particular, it allows dependencies to be replaced with mock implementations during unit testing, without requiring the local API server to be running.

This separation of responsibilities improves maintainability, testability, and the ability to evolve the API integration without tightly coupling the UI to the underlying data structure.

### State Management and Error Handling

The **ViewModel** manages the UI state and exposes it to the SwiftUI views, keeping presentation logic separate from networking and data processing.

- **Loading:** a loading state is displayed while listings are being fetched.
- **Success:** the retrieved entities are published to the UI.
- **Empty:** if the response contains no listings, an intentional empty state is displayed instead of a blank screen.
- **Error:** in case of a network or API error, the ViewModel exposes an error state so the UI can inform the user and provide a way to retry the request.

This approach ensures that each stage of the data-fetching process is handled explicitly, providing clear feedback to users and keeping the UI consistent and responsive.

### Testing Strategy

I implemented two complementary testing approaches for both **categories and listings**.

- **Unit testing:** I tested DTO decoding using mock JSON data to verify that API responses are correctly decoded into the expected data structures. These tests are deterministic because they rely on predefined fixtures and do not require network requests or a running server.
- **Integration testing:** I tested the data flow from the API response to the DTO and then through the mapper to the final domain entity. This validates that the different components work together correctly, from data retrieval to model transformation.

The unit tests can run independently of the local server, while the integration tests rely on the local API server to validate the complete data flow for both categories and listings.

---

## 3. Product and UX Decisions

### Scope and Priorities

I prioritized the **data and model layers first**, focusing on DTOs, mappers, and domain entities to establish a clear separation of responsibilities and ensure maintainability. I also implemented dependency injection to reduce coupling and improve testability.

Once these foundations were in place, I focused on the presentation layer, implementing the SwiftUI views and ViewModels to manage UI state and display the data.

I prioritized a clean, testable architecture and the core functional requirements over additional features or unnecessary architectural complexity. This allowed me to deliver a solution that is straightforward to maintain and extend.

---

## 4. Assumptions and Ambiguities

The `/listings` endpoint provides a `category_id` for each listing rather than the complete category object. This means additional data is required to display the category name in the UI.

**Assumption and decision:** I assumed that the category information returned by `/categories` could be used to resolve each listing's `category_id`. I therefore fetch the categories separately and use the previously retrieved category data to find the corresponding category object for each listing.

---

## 5. AI Usage

### Tools Used

| Tool | Purpose |
| --- | --- |
| Stitch AI | Generate initial UI designs for the Home and Listing Details screens based on the provided specifications. |
| Claude | Assist in implementing the SwiftUI views based on the generated UI designs. |
| ChatGPT (GPT) | Refine and improve the wording of `REFLECTION.md` to clearly communicate implementation choices, architectural decisions, and tradeoffs. |

### AI Suggestion Rejected, Corrected, or Rewritten

**Initial suggestions:**

- Claude initially implemented multiple UI elements within a single view.
- Claude suggested using `.navigationDestination` with a closure in the `HomeCell` component.

**My decisions:**

- I refactored the UI into smaller, reusable components, using bindings and closures where appropriate to manage state and handle user interactions.
- I replaced `.navigationDestination` with `NavigationLink` to ensure compatibility with the project's iOS 16+ deployment target.

**Reasoning:**

- Splitting the UI into smaller components improves readability, maintainability, and reusability. It also makes each component easier to understand, test, and evolve independently.
- The project requires iOS 16+ compatibility, whereas the closure-based `.navigationDestination` API requires iOS 17+. Using `NavigationLink` provides a suitable navigation solution while respecting the minimum deployment target.

---

## 6. Limitations and Future Improvements

### Current Limitations

- The application currently retrieves listings without incremental pagination.
- Search and category filtering are handled on the client side, based on the data already fetched.
- Image caching is not yet implemented.

### Potential Improvements

- **Server-side pagination:** Fetch listings incrementally, 20 items per request, to reduce initial loading time and network usage. This would require adapting search and category filtering to work through the server API to ensure results remain accurate across pages.
- **Image caching:** Introduce an image-caching mechanism to avoid repeatedly downloading the same images, improve scrolling performance, and provide a smoother user experience.

### Production Considerations

Before production deployment, I would further optimize network requests and image loading, ensure pagination handles duplicate items and loading or retry states correctly, and verify that search and filtering remain consistent with server-side pagination.

---

## 7. Final Notes

This assessment allowed me to prioritize clean architecture, testability, and maintainability while meeting the core requirements, with server-side pagination and image caching as the next improvements.
