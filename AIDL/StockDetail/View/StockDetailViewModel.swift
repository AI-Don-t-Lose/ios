import Foundation
import SwiftUI

@MainActor
class StockDetailViewModel: ObservableObject {
  // MARK: - Published Properties

  @Published var stockInfo: StockInfo?
  @Published var consumerScore: ConsumerMatchingScore?
  @Published var aiBriefing: AIBriefing?
  @Published var isLoading = false

  // MARK: - Private Properties

  private let networkClient = NetworkClient()
  private let stockName: String

  // MARK: - Initialization

  init(stockName: String) {
    self.stockName = stockName
  }

  // MARK: - Public Methods

  func loadStockData() async {
    await MainActor.run {
      isLoading = true
    }

    do {
      // Fetch stock price and recommendation data concurrently
      async let priceData = fetchStockPrice()
      async let recommendationData = fetchStockRecommendation()

      let (price, recommendation) = try await (priceData, recommendationData)

      await MainActor.run {
        self.stockInfo = StockInfo(from: price.data)
        self.consumerScore = ConsumerMatchingScore(from: recommendation)
        self.aiBriefing = AIBriefing(from: recommendation)
        self.isLoading = false
      }
    } catch {
      await MainActor.run {
        self.stockInfo = nil
        self.consumerScore = nil
        self.aiBriefing = nil
        self.isLoading = false
      }
    }
  }

  // MARK: - Private Methods

  private func fetchStockPrice() async throws -> PriceEndpoint.Response {
    let endpoint = PriceEndpoint(stockName: stockName)
    return try await networkClient.requestValidated(endpoint)
  }

  private func fetchStockRecommendation() async throws -> RecommendStockEndpoint.Response {
    let endpoint = RecommendStockEndpoint(stockName: stockName)
    return try await networkClient.requestValidated(endpoint)
  }
}
