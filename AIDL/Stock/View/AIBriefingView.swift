import SwiftUI

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

#Preview {
  AIBriefingView(briefing: AIBriefing(
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
  ))
}
