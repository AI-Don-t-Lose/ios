import SwiftUI

// MARK: - Content View

struct ContentView: View {
  var body: some View {
    NavigationView {
      MainView()
        .navigationBarHidden(true)
    }
  }
}

#Preview {
  ContentView()
}
