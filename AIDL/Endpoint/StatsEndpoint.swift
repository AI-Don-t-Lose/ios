//
//  StatsEndpoint.swift
//  AIDL
//
//  Created by Jinyoung Kim on 9/16/25.
//

import Foundation

struct StatsEndpoint: HTTPEndpoint {
  typealias Header = [String: String]

  struct Response: Decodable {
    struct Category: Decodable {
      let category: String
      let percentage: Double
    }

    let date: String
    let stats: [Category]
  }

  struct Query: Encodable {}

  let url: URL = Environment.baseURL
  let path: String = "/stats"
  let method: HTTPMethod = .get
  var headers: Header? {
    return ["Authorization": "Bearer \(Environment.apiToken)"]
  }

  let query: Query? = .init()
  let body: Data? = nil
}
