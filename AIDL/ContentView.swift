import SwiftUI

// MARK: - Content View

struct ContentView: View {
  var body: some View {
    NavigationView {
      StockDetailView(stockName: "넷마블")
        .navigationBarHidden(true)
    }
  }
}

#Preview {
  ContentView()
}
