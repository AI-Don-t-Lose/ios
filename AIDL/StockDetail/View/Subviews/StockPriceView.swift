import SwiftUI

// MARK: - Stock Price View

struct StockPriceView: View {
  let stockInfo: StockInfo

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack(alignment: .bottom, spacing: 8) {
        // 현재가
        Text(formatPrice(stockInfo.currentPrice))
          .font(.largeTitle)
          .fontWeight(.bold)
          .foregroundColor(stockInfo.isPositive ? .red : .blue)

        // 등락 표시
        HStack(spacing: 4) {
          Image(systemName: stockInfo.isPositive ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
            .font(.caption)
            .foregroundColor(stockInfo.isPositive ? .red : .blue)

          Text(formatPrice(abs(stockInfo.priceChange)))
            .font(.body)
            .foregroundColor(stockInfo.isPositive ? .red : .blue)
        }

        Spacer()

        // 등락 퍼센트
        Text(String(format: "%.2f%%", abs(stockInfo.priceChangePercent)))
          .font(.title)
          .fontWeight(.bold)
          .foregroundColor(stockInfo.isPositive ? .red : .blue)
      }
    }
    .padding(.horizontal, 20)
  }

  private func formatPrice(_ price: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 0
    return formatter.string(from: NSNumber(value: price)) ?? "\(Int(price))"
  }
}

#Preview {
  StockPriceView(stockInfo: StockInfo(
    name: "종목명",
    currentPrice: 17350,
    previousPrice: 17870
  ))
}
