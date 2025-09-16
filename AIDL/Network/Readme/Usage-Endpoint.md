```swift
struct TestEndpoint: HTTPEndpoint {
  typealias Header = [String: String]

  struct Response: Decodable {
    let code: Int
    let message: String
    let data: Data
  }

  struct Query: Encodable {
    let id = "123"
    let date = "20250916"
  }

  let url: URL = .init(string: "\(Environment.baseURL)/test")!
  let method: HTTPMethod = .get
  var headers: Header? {
    return ["Authorization": "Bearer \(Environment.apiToken)"]
  }

  let query: Query? = .init()
  let body: Data? = nil
}
```
