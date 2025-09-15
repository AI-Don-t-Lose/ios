import SwiftUI

// MARK: - Content View

struct ContentView: View {
  var body: some View {
    NavigationView {
      StockDetailView()
        .navigationBarHidden(true)
    }
  }
}

#Preview {
  ContentView()
}
