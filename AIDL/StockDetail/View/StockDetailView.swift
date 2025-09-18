import SwiftUI

// MARK: - Main Stock Detail View

struct StockDetailView: View {
  let stockInfo = StockInfo(
    name: "종목명",
    currentPrice: 17350,
    fluctuationRate: -2.91,
    vsAmount: -520
  )

  let consumerScore = ConsumerMatchingScore(
    score: 95,
    reason: "GPT스타일 소비 생활과 반영하다는 내용 등과 같이"
  )

  let aiBriefing = AIBriefing(
    baseDate: "2025.08.28 종가 기준",
    briefingContent: "AI가 분석한 종목 브리핑 내용",
    newsList: [
      NewsItem(
        link: "https://example.com/news1",
        summary: "뉴스 내용 미리보기 뉴스 내용 미리보기 뉴스 내용 미리보기 뉴스 내용 미리보기 뉴스 내용 미리보기",
        date: "2025.08.28 Yahoo News"
      ),
      NewsItem(
        link: "https://example.com/news2",
        summary: "뉴스 내용 미리보기 뉴스 내용 미리보기 뉴스 내용 미리보기 뉴스 내용 미리보기 뉴스 내용 미리보기",
        date: "2025.08.27 Y News"
      ),
    ]
  )

  var body: some View {
    ScrollView {
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
      .padding(.top, 20)
    }
    .background(Color.white)
  }
}

#Preview {
  StockDetailView()
}
