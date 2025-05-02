//
//  CountriesAppTests.swift
//  CountriesAppTests
//
//  Created by Anusha Raju on 5/02/25.
//

import XCTest
@testable import CountriesApp

final class CountriesAppTests: XCTestCase {

    var viewModel: NationListViewModel!
    var mockService: MockDataFetcher!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockService = MockDataFetcher()
        viewModel = NationListViewModel(dataFetcher: mockService)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockService = nil
        try super.tearDownWithError()
    }
    
    func testFetchNationsSuccess() async {
        await viewModel.loadData()
        XCTAssertEqual(viewModel.getNationsCount(), 7)
        XCTAssertEqual(viewModel.getNationsCount(), 7)
        XCTAssertEqual(viewModel.nations.first?.name, "Afghanistan")
    }

    func testFilterByName() async {
        await viewModel.loadData()
        viewModel.search(for: "American Samoa")
        XCTAssertEqual(viewModel.visibleNations.count, 1)
        XCTAssertEqual(viewModel.visibleNations.first?.name, "American Samoa")
    }

    func testFilterByCapital() async {
        await viewModel.loadData()
        viewModel.search(for: "Luanda")
        XCTAssertEqual(viewModel.visibleNations.count, 1)
        XCTAssertEqual(viewModel.visibleNations.first?.capital, "Luanda")
    }

    func testEmptySearchQuery() async {
        await viewModel.loadData()
        viewModel.search(for: "")
        XCTAssertEqual(viewModel.visibleNations.count, 7)
    }

}

final class WebDataFetcherTests: XCTestCase {

    func testMockFetchSuccess() async {
        let mockDataFetcher = MockDataFetcher()
        let result = await mockDataFetcher.requestData(Endpoint.countryListURL, type: [Nation].self)

        switch result {
        case .success(let nations):
            XCTAssertEqual(nations.count, 7)
        case .failure:
            XCTFail("Expected successful mock response")
        }
    }
}


final class FetchErrorTests: XCTestCase {

    func testFetchErrorMessages() {
        let invalidURL = FetchError.invalidURL
        XCTAssertEqual(invalidURL.message, "The URL provided is invalid.")

        let emptyData = FetchError.emptyData
        XCTAssertEqual(emptyData.message, "No data was returned by the server.")
    }
}
