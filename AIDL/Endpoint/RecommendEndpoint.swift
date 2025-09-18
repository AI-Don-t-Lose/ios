import Foundation

struct RecommendEndpoint: HTTPEndpoint {
  typealias Header = [String: String]

  struct Response: Decodable {
    let date: String
    let stocks: [String]
  }

  struct Query: Encodable {}

  let url: URL = Environment.baseURL
  let path: String = "/recommend"
  let method: HTTPMethod = .get
  var headers: Header? {
    return ["Authorization": "Bearer \(Environment.apiToken)"]
  }

  let query: Query? = .init()
  let body: Data? = nil
}
