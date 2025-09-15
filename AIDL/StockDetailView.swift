import SwiftUI

// MARK: - Data Models

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

// MARK: - Main View

struct StockDetailView: View {
  let stockInfo = StockInfo(
    name: "종목명",
    currentPrice: 17350,
    previousPrice: 17870
  )

  let consumerScore = ConsumerMatchingScore(
    score: 95,
    content: "GPT스타일 소비 생활과 반영하다는 내용 등과 같이"
  )

  let aiBriefing = AIBriefing(
    baseDate: "2025.08.28 종가 기준",
    briefingContent: "AI가 분석한 종목 브리핑 내용",
    newsList: [
      NewsItem(
        date: "2025.08.28 Yahoo News",
        content: "뉴스 내용 미리보기 뉴스 내용 미리보기 뉴스 내용 미리보기 뉴스 내용 미리보기 뉴스 내용 미리보기"
      ),
      NewsItem(
        date: "2025.08.27 Y News",
        content: "뉴스 내용 미리보기 뉴스 내용 미리보기 뉴스 내용 미리보기 뉴스 내용 미리보기 뉴스 내용 미리보기"
      ),
    ]
  )

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {
        // 종목명
        Text(stockInfo.name)
          .font(.title2)
          .fontWeight(.bold)
          .padding(.horizontal, 20)

        // 주식 가격 정보
        StockPriceView(stockInfo: stockInfo)

        // 소비 생활 매칭 점수
        ConsumerScoreView(score: consumerScore)

        // AI 종목 브리핑
        AIBriefingView(briefing: aiBriefing)

        Spacer(minLength: 40)
      }
      .padding(.top, 20)
    }
    .background(Color(.systemBackground))
  }
}

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

        // 등락 퍼센트
        Text(String(format: "%.2f%%", abs(stockInfo.priceChangePercent)))
          .font(.body)
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

// MARK: - Consumer Score View

struct ConsumerScoreView: View {
  let score: ConsumerMatchingScore

  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("내 소비 생활과의 매칭 점수는..")
        .font(.body)
        .foregroundColor(.primary)
        .padding(.horizontal, 20)

      HStack {
        Spacer()
        Text("\(score.score)점")
          .font(.system(size: 48, weight: .bold))
          .foregroundColor(.red)
          .padding(.horizontal, 20)
        Spacer()
      }

      Text(score.content)
        .font(.caption)
        .foregroundColor(.secondary)
        .padding(.horizontal, 20)
    }
  }
}

// MARK: - AI Briefing View

struct AIBriefingView: View {
  let briefing: AIBriefing

  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("AI 종목 브리핑")
        .font(.title3)
        .fontWeight(.semibold)
        .padding(.horizontal, 20)

      Text(briefing.baseDate)
        .font(.caption)
        .foregroundColor(.secondary)
        .padding(.horizontal, 20)

      // AI 분석 박스
      Rectangle()
        .fill(Color(.systemGray5))
        .frame(height: 120)
        .overlay(
          Text(briefing.briefingContent)
            .font(.body)
            .foregroundColor(.secondary)
        )
        .cornerRadius(8)
        .padding(.horizontal, 20)

      // 뉴스 섹션
      NewsListView(newsList: briefing.newsList)
    }
  }
}

// MARK: - News List View

struct NewsListView: View {
  let newsList: [NewsItem]

  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      ForEach(Array(newsList.enumerated()), id: \.offset) { index, newsItem in
        NewsItemView(newsItem: newsItem)

        if index < newsList.count - 1 {
          Divider()
            .padding(.horizontal, 20)
        }
      }
    }
  }
}

// MARK: - News Item View

struct NewsItemView: View {
  let newsItem: NewsItem

  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      Text(newsItem.date)
        .font(.caption)
        .fontWeight(.medium)
        .foregroundColor(.primary)

      Text(newsItem.content)
        .font(.caption)
        .foregroundColor(.secondary)
        .lineLimit(2)
        .multilineTextAlignment(.leading)
    }
    .padding(.horizontal, 20)
  }
}

// MARK: - Content View

struct MyContentView: View {
  var body: some View {
    NavigationView {
      StockDetailView()
        .navigationBarHidden(true)
    }
  }
}

#Preview {
  MyContentView()
}
