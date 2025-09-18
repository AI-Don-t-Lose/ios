import Foundation

// MARK: - Date Formatting Extension

extension String {
  /// Converts ISO date string to Korean format (e.g., "2025년 9월 17일")
  var koreanDateString: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    formatter.timeZone = TimeZone(abbreviation: "UTC")

    guard let date = formatter.date(from: self) else {
      return self // Return original string if parsing fails
    }

    let koreanFormatter = DateFormatter()
    koreanFormatter.dateFormat = "yyyy년 M월 d일"
    koreanFormatter.locale = Locale(identifier: "ko_KR")

    return koreanFormatter.string(from: date)
  }
}

// MARK: - Stock Data Models

struct StockInfo {
  let name: String
  let currentPrice: Double
  let fluctuationRate: Double
  let vsAmount: Double

  var priceChange: Double {
    vsAmount
  }

  var priceChangePercent: Double {
    fluctuationRate
  }

  var isPositive: Bool {
    vsAmount >= 0
  }

  // Convenience initializer for mock data
  init(name: String, currentPrice: Double, fluctuationRate: Double, vsAmount: Double) {
    self.name = name
    self.currentPrice = currentPrice
    self.fluctuationRate = fluctuationRate
    self.vsAmount = vsAmount
  }

  // Initialize from PriceEndpoint.Response.Data
  init(from priceData: PriceEndpoint.Response.Data) {
    name = priceData.name
    currentPrice = priceData.price.current
    fluctuationRate = priceData.price.fluctuationRate
    vsAmount = priceData.price.vsAmount
  }
}

struct ConsumerMatchingScore {
  let score: Int
  let reason: String

  // Convenience initializer for mock data
  init(score: Int, reason: String) {
    self.score = score
    self.reason = reason
  }

  // Initialize from RecommendStockEndpoint.Response
  init(from response: RecommendStockEndpoint.Response) {
    score = response.score
    reason = response.reason
  }
}

struct NewsItem {
  let link: String
  let summary: String
  let date: String

  // Convenience initializer for mock data
  init(link: String, summary: String, date: String) {
    self.link = link
    self.summary = summary
    self.date = date.koreanDateString
  }

  // Initialize from RecommendStockEndpoint.Response.News
  init(from news: RecommendStockEndpoint.Response.News) {
    link = news.link
    summary = news.summary
    date = news.date.koreanDateString
  }
}

struct AIBriefing {
  let baseDate: String
  let briefingContent: String
  let newsList: [NewsItem]

  // Convenience initializer for mock data
  init(baseDate: String, briefingContent: String, newsList: [NewsItem]) {
    self.baseDate = baseDate.koreanDateString
    self.briefingContent = briefingContent
    self.newsList = newsList
  }

  // Initialize from RecommendStockEndpoint.Response
  init(from response: RecommendStockEndpoint.Response) {
    baseDate = response.summary.date.koreanDateString
    briefingContent = response.summary.contents
    newsList = response.news.map { NewsItem(from: $0) }
  }
}
