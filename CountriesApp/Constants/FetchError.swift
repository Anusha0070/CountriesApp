//
//  FetchError.swift
//  CountriesApp
//
//  Created by Anusha Raju on 5/02/25.
//

enum FetchError: Error {
    case invalidURL
    case requestFailed(Error)
    case emptyData
    case decodingIssue(Error)

    var message: String {
        switch self {
        case .invalidURL:
            return "The URL provided is invalid."
        case .requestFailed(let error):
            return "Request failed: \(error.localizedDescription)"
        case .emptyData:
            return "No data was returned by the server."
        case .decodingIssue(let error):
            return "Failed to decode the response: \(error.localizedDescription)"
        }
    }
}
