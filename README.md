# 🌍 CountriesApp

CountriesApp is an iOS application built with UIKit that displays a list of countries in a clean and responsive `UITableView`. It allows users to search for countries by **name** or **capital** using a `UISearchController`.

This app demonstrates a modular and testable MVVM architecture and uses modern Swift features including `async/await`, custom error handling, dependency injection, and unit testing.

---

## 🧩 Features

- ✅ Fetches real-time country data from a remote JSON endpoint
- 🔍 Live search by country name or capital city
- 🧼 Clean architecture with separation of concerns (MVVM)
- 📱 Adaptive layout for iPhone and iPad
- 🧪 Unit-tested ViewModel with mock networking

## 🧠 Architecture

This app follows a structured **MVVM** design:

- **Model**: `Nation` struct conforms to `Codable`
- **ViewModel**: `NationListViewModel` handles fetching, filtering, and exposes data to the view
- **View**: `NationViewController` updates UI based on ViewModel output
- **Networking**: `DataFetcherService` protocol allows mocking real vs test network layers



## Video Walkthrough



