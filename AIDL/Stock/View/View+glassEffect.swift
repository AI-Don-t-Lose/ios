import SwiftUI

struct GlassModifier: ViewModifier {
  let cornerRadius: CGFloat
  let material: Material

  init(cornerRadius: CGFloat = 16, material: Material = .ultraThinMaterial) {
    self.cornerRadius = cornerRadius
    self.material = material
  }

  func body(content: Content) -> some View {
    content
      .background(material, in: RoundedRectangle(cornerRadius: cornerRadius))
      .overlay(
        ZStack {
          LinearGradient(
            colors: [
              Color.black.opacity(0.007),
              Color.clear,
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
          )
          .clipShape(RoundedRectangle(cornerRadius: cornerRadius))

          RadialGradient(
            colors: [
              Color.black.opacity(0.015),
              Color.clear,
            ],
            center: .center,
            startRadius: 30,
            endRadius: 0
          )
          .clipShape(RoundedRectangle(cornerRadius: cornerRadius))

          RoundedRectangle(cornerRadius: cornerRadius)
            .stroke(
              Color.white.opacity(0.8),
              lineWidth: 1.7,
            )
        }
      )
      .background(
        RoundedRectangle(cornerRadius: cornerRadius)
          .fill(Color.white)
          .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.2), radius: 12)
      )
  }
}

extension View {
  func glassEffect(cornerRadius: CGFloat = 16, material: Material = .ultraThinMaterial) -> some View {
    modifier(GlassModifier(cornerRadius: cornerRadius, material: material))
  }
}

struct GlassEffectTestView: View {
  var body: some View {
    VStack {
      Text("Hello, World!")
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .glassEffect()
    .padding(10.0)
  }
}

#Preview {
  GlassEffectTestView()
}
