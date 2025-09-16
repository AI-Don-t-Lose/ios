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

  let url: URL = .init(string: "https://example.com")!
  let method: HTTPMethod = .get
  var headers: Header? {
    let token = "token"
    return ["Authorization": "Bearer \(token)"]
  }
  let query: Query? = .init()
  let body: Data? = nil

  init() {}
}
```