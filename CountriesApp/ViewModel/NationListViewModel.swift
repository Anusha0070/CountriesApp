//
//  NationListViewModel.swift
//  CountriesApp
//
//  Created by Anusha Raju on 5/02/25.
//

import Foundation

class NationListViewModel {
    private let dataFetcher: DataFetcherService
    var nations: [Nation] = []
    var visibleNations: [Nation] = []
    var completionHandler: ((String?) -> ())?

    init(dataFetcher: DataFetcherService) {
        self.dataFetcher = dataFetcher
    }

    func loadData() async {
        let result = await dataFetcher.requestData(Endpoint.countryListURL, type: [Nation].self)
        switch result {
        case .success(let data):
            nations = data
            visibleNations = data
            self.completionHandler?(nil)
        case .failure(let error):
            self.completionHandler?(error.localizedDescription)
        }
    }
    
    func getNationsCount() -> Int {
        return visibleNations.count
    }
    
    func getNationDetails(index: Int) -> Nation {
        return visibleNations[index]
    }

    func search(for query: String) {
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedQuery.isEmpty else {
            visibleNations = nations
            completionHandler?(nil)
            return
        }
        visibleNations = nations.filter {
            ($0.name?.localizedCaseInsensitiveContains(trimmedQuery) ?? false) ||
            ($0.capital?.localizedCaseInsensitiveContains(trimmedQuery) ?? false)
        }
        completionHandler?(nil)
    }

}
