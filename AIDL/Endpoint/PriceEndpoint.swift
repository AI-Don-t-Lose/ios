//
//  PriceEndpoint.swift
//  AIDL
//
//  Created by Assistant on 9/16/25.
//

import Foundation

struct PriceEndpoint: HTTPEndpoint {
  typealias Header = [String: String]

  struct Response: Decodable {
    let code: Int
    struct Data: Decodable {
      let date: String
      struct Price: Decodable {
        let current: Double
        let fluctuationRate: Double
        let vsAmount: Double
      }

      let price: Price
      let name: String
    }

    let data: Data
    let message: String
  }

  struct Query: Encodable {}

  let stockName: String

  let url: URL = Environment.baseURL
  var path: String { "/stock/price/\(stockName)" }
  let method: HTTPMethod = .get
  var headers: Header? {
    return ["Authorization": "Bearer \(Environment.apiToken)"]
  }

  let query: Query? = .init()
  let body: Data? = nil

  init(stockName: String) {
    self.stockName = stockName
  }
}
