//
//  MockDataFetcher.swift
//  CountriesApp
//
//  Created by Anusha Raju on 5/02/25.
//

import Foundation

final class MockDataFetcher: DataFetcherService {
    func requestData<T: Decodable>(_ url: URL, type: T.Type) async -> Result<T, FetchError> {

        let data = Data(mockJSON.utf8)
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return .success(decoded)
        } catch {
            return .failure(.decodingIssue(error))
        }
    }
}

let mockJSON = """
[
  {
    "capital": "Kabul",
    "code": "AF",
    "currency": {
      "code": "AFN",
      "name": "Afghan afghani",
      "symbol": "؋"
    },
    "flag": "https://restcountries.eu/data/afg.svg",
    "language": {
      "code": "ps",
      "name": "Pashto"
    },
    "name": "Afghanistan",
    "region": "AS"
  },
  {
    "capital": "Mariehamn",
    "code": "AX",
    "currency": {
      "code": "EUR",
      "name": "Euro",
      "symbol": "€"
    },
    "flag": "https://restcountries.eu/data/ala.svg",
    "language": {
      "code": "sv",
      "name": "Swedish"
    },
    "name": "Åland Islands",
    "region": "EU"
  },
  {
    "capital": "Tirana",
    "code": "AL",
    "currency": {
      "code": "ALL",
      "name": "Albanian lek",
      "symbol": "L"
    },
    "flag": "https://restcountries.eu/data/alb.svg",
    "language": {
      "code": "sq",
      "name": "Albanian"
    },
    "name": "Albania",
    "region": "EU"
  },
  {
    "capital": "Algiers",
    "code": "DZ",
    "currency": {
      "code": "DZD",
      "name": "Algerian dinar",
      "symbol": "د.ج"
    },
    "flag": "https://restcountries.eu/data/dza.svg",
    "language": {
      "code": "ar",
      "name": "Arabic"
    },
    "name": "Algeria",
    "region": "AF"
  },
  {
    "capital": "Pago Pago",
    "code": "AS",
    "currency": {
      "code": "USD",
      "name": "United State Dollar",
      "symbol": "$"
    },
    "flag": "https://restcountries.eu/data/asm.svg",
    "language": {
      "code": "en",
      "name": "English"
    },
    "name": "American Samoa",
    "region": "OC"
  },
  {
    "capital": "Andorra la Vella",
    "code": "AD",
    "currency": {
      "code": "EUR",
      "name": "Euro",
      "symbol": "€"
    },
    "flag": "https://restcountries.eu/data/and.svg",
    "language": {
      "code": "ca",
      "name": "Catalan"
    },
    "name": "Andorra",
    "region": "EU"
  },
  {
    "capital": "Luanda",
    "code": "AO",
    "currency": {
      "code": "AOA",
      "name": "Angolan kwanza",
      "symbol": "Kz"
    },
    "flag": "https://restcountries.eu/data/ago.svg",
    "language": {
      "code": "pt",
      "name": "Portuguese"
    },
    "name": "Angola",
    "region": "AF"
  }
]
"""
