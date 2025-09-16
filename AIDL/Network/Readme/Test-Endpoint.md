```swift
import SwiftUI

@main
struct AIDLApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
        .task {
          await TestNetwork.testRequest()
        }
    }
  }
}

class TestNetwork {
  static func testRequest() async {
    let endpoint = StockPriceEndpoint(stockName: "네이버")
    do {
      let response = try await NetworkClient().request(endpoint)
      print(response.data)
      print(response.response)
    } catch {
      print(error)
    }
  }
}
```
