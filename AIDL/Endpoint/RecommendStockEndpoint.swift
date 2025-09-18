//
//  RecommendStockEndpoint.swift
//  AIDL
//
//  Created by Jinyoung Kim on 9/18/25.
//

import Foundation

struct RecommendStockEndpoint: HTTPEndpoint {
  typealias Header = [String: String]

  struct Response: Decodable {
    struct Summary: Decodable {
      let date: String
      let contents: String
    }

    struct News: Decodable {
      let link: String
      let summary: String
      let date: String
    }

    let score: Int
    let reason: String
    let summary: Summary
    let news: [News]
  }

  struct Query: Encodable {}

  let stockName: String
  let url: URL = Environment.baseURL
  var path: String { "/recommend/\(stockName)" }
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
