//
//  DataFetcherService.swift
//  CountriesApp
//
//  Created by Anusha Raju on 5/02/25.
//

import Foundation

protocol DataFetcherService {
    func requestData<T: Decodable>(_ url: URL, type: T.Type) async -> Result<T, FetchError>
}
