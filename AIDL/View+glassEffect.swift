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
              Color.black.opacity(0.08),
              Color.black.opacity(0.05),
              Color.clear,
            ],
            startPoint: .top,
            endPoint: .bottom
          )
          RoundedRectangle(cornerRadius: cornerRadius)
            .stroke(
              LinearGradient(
                colors: [
                  Color.black.opacity(0.2),
                  Color.black.opacity(0.07),
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
              ),
              lineWidth: 1,
            )
        }
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
