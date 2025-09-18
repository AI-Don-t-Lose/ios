import SwiftUI

// MARK: - Main Stock Detail View

struct StockDetailView: View {
  @StateObject private var viewModel: StockDetailViewModel

  init(stockName: String) {
    _viewModel = StateObject(wrappedValue: StockDetailViewModel(stockName: stockName))
  }

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 10) {
        if viewModel.isLoading {
          loadingView
        } else if let stockInfo = viewModel.stockInfo,
                  let consumerScore = viewModel.consumerScore,
                  let aiBriefing = viewModel.aiBriefing
        {
          contentView(stockInfo: stockInfo, consumerScore: consumerScore, aiBriefing: aiBriefing)
        } else {
          dataIncompleteView
        }
      }
      .padding(.top, 20)
    }
    .background(Color.white)
    .task {
      await viewModel.loadStockData()
    }
  }

  // MARK: - View Components

  private func contentView(stockInfo: StockInfo, consumerScore: ConsumerMatchingScore, aiBriefing: AIBriefing) -> some View {
    VStack(alignment: .leading, spacing: 10) {
      // 종목명
      Text(stockInfo.name)
        .font(.title2)
        .fontWeight(.bold)
        .padding(.horizontal, 20)

      VStack(spacing: 10) {
        // 주식 가격 정보
        StockPriceView(stockInfo: stockInfo)
        // 소비 생활 매칭 점수
        ConsumerScoreView(score: consumerScore)
      }
      .padding()
      .glassEffect()
      .padding()

      // AI 종목 브리핑
      AIBriefingView(briefing: aiBriefing)
        .padding()
        .glassEffect()
        .padding()

      Spacer(minLength: 40)
    }
  }

  private var loadingView: some View {
    VStack(spacing: 20) {
      ProgressView()
        .scaleEffect(1.5)
      Text("데이터를 불러오는 중...")
        .font(.body)
        .foregroundColor(.secondary)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .padding(.top, 100)
  }

  private var dataIncompleteView: some View {
    VStack(spacing: 20) {
      Image(systemName: "exclamationmark.triangle")
        .font(.system(size: 50))
        .foregroundColor(.orange)

      Text("내용을 불러올 수 없습니다")
        .font(.headline)

      Text("데이터를 불러오는 중 문제가 발생했습니다. 다시 시도해 주세요.")
        .font(.body)
        .foregroundColor(.secondary)
        .multilineTextAlignment(.center)
        .padding(.horizontal)

      Button("다시 시도") {
        Task {
          await viewModel.loadStockData()
        }
      }
      .buttonStyle(.borderedProminent)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .padding(.top, 100)
  }
}

#Preview {
  StockDetailView(stockName: "삼성전자")
}
