//
//  RecommendEndpoint.swift
//  AIDL
//
//  Created by Jinyoung Kim on 9/17/25.
//

import Foundation

struct StockPriceEndpoint: HTTPEndpoint {
  typealias Header = [String: String]

  struct Response: Decodable {}

  struct Query: Encodable {}

  let url: URL = .init(string: "\(Environment.baseURL)/stock/price")!
  let path: String
  let method: HTTPMethod = .get
  var headers: Header? {
    return ["Authorization": "Bearer \(Environment.apiToken)"]
  }

  let query: Query? = .init()
  let body: Data? = nil

  init(stockName: String) {
    self.path = "/\(stockName)"
  }
}
