# Woofly – The Dog Pictures App

## Overview
I really enjoyed the tech test especially all the cute dogs fetched from the API.

Here is a quick video recording of the Woofly app in action. It shows all required features of listing all the breeds and fetching 10 random images of the selected breed. The recording shows dynamic text sizes, landscape, portrait, dark and light mode. [https://www.loom.com/share/ca641747576a4e90bd09565e72fd2420](https://www.loom.com/share/ca641747576a4e90bd09565e72fd2420)

As per requirement, Woofly was built with two screens and with SwiftUI. It showcases a list of dog breeds retrieved from the [Dog CEO API](https://dog.ceo/dog-api/), allowing users to select a breed and view a collection of 10 random images for that breed. Sub breeds is out of scope. 

## Features
- **Breed List Screen:** Fetches and displays all dog breeds in a scrollable list. It also shows a small thumbnail which is reused as a hero image in the next screen.
- **Breed Detail Screen:** Tapping a breed shows 10 random images of the selected breed. The layout of the images are in alternating chunks of 2 and 1 images per row. This is inspired form the Instagram app.  It also shows a hero image at the top of the list.
- **Loading & Error Handling:** The UI reflects loading states and error messages.
- **Mocking:** Shared mocks for consistent data in the main app and test targets.

## Architecture & Patterns
- **MVVM:** The project is structured around the Model-View-ViewModel architecture:
  - `BreedsListViewModel` and `BreedDetailViewModel` handle business logic, data fetching, and state management.
  - SwiftUI Views observe these view models for reactive UI updates.
- **Protocols for API:** The `DogAPIProviding` protocol abstracts API access. This allows for easy mocking and testing, as well as future extensibility.
- **SwiftUI First:** The app is written fully in SwiftUI for declarative, maintainable user interfaces, using idiomatic bindings and property wrappers (e.g., `@Published`, `@StateObject`).

## Testing & Mocking
- **MockDogJSON:** Centralized struct containing JSON samples for breed lists and images, as well as negative test data. Used both in the main app unit tests, as well as the `DogAPI` unit tests package ensuring consistency and reusability.
- **MockDogAPI:** Implements the `DogAPIProviding` protocol to deliver mock responses for all endpoints using data from `MockDogJSON`.
- **Unit/UI Tests:** The project includes Swift Testing. Mocks can be swapped for real or test data as needed.

## Setup
1. Clone the repository.
2. Open the project in Xcode 26 or later.
3. Run the app on an iOS Simulator or device (iOS 17+).

## Suggestions for Further Improvement
- **UI/UX:**
  - Use `matchedGeometryEffect`  for the thumbnail and hero images as implemented by KavSoft: https://www.youtube.com/watch?v=cyVQJ31AYKs
  - Support for breed search/filtering.
  - Use Liquid Glass on the floating search and filter controls.
  - Improve error and empty state presentation.
- **Testing:**
  - Increase coverage for failure scenarios and edge cases.
  - Integrate snapshot/UI testing for visual consistency.
- **Architecture:**
  - Adopt Swift’s new features (like macros, InlineArray, etc.) where beneficial.

## Conclusion
Woofly is designed to be a clean, extensible foundation for any dog showcase app. The use of MVVM, protocol abstraction, and SwiftUI ensures maintainability and testability for future growth. I hope you like my code and allow me to join and contribute to Chip.

---

*Created as part of a technical assessment. Woof!*
