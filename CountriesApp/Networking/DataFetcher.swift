//
//  DataFetcher.swift
//  CountriesApp
//
//  Created by Anusha Raju on 5/02/25.
//

import Foundation

final class DataFetcher: DataFetcherService {
    static let instance = DataFetcher()
    private init() {}

    func requestData<T: Decodable>(_ url: URL, type: T.Type) async -> Result<T, FetchError> {
        let request = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse,
                  200..<300 ~= httpResponse.statusCode else {
                return .failure(.requestFailed(NSError(domain: "Invalid status code", code: (response as? HTTPURLResponse)?.statusCode ?? -1)))
            }

            guard !data.isEmpty else {
                return .failure(.emptyData)
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return .success(decodedData)
            } catch {
                return .failure(.decodingIssue(error))
            }

        } catch {
            return .failure(.requestFailed(error))
        }
    }
}
