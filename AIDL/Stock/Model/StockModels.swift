import Foundation

// MARK: - Stock Data Models

struct StockInfo {
  let name: String
  let currentPrice: Double
  let previousPrice: Double

  var priceChange: Double {
    currentPrice - previousPrice
  }

  var priceChangePercent: Double {
    guard previousPrice != 0 else { return 0 }
    return (priceChange / previousPrice) * 100
  }

  var isPositive: Bool {
    priceChange >= 0
  }
}

struct ConsumerMatchingScore {
  let score: Int
  let content: String
}

struct NewsItem {
  let date: String
  let content: String
}

struct AIBriefing {
  let baseDate: String
  let briefingContent: String
  let newsList: [NewsItem]
}
