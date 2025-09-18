import SwiftUI

// MARK: - AI Briefing View

struct AIBriefingView: View {
  let briefing: AIBriefing

  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("AI 종목 브리핑")
        .font(.title3)
        .fontWeight(.semibold)
        .foregroundColor(.primary)
        .padding(.horizontal, 20)

      Text(briefing.baseDate)
        .font(.caption)
        .foregroundColor(.primary)
        .padding(.horizontal, 20)

      // AI 분석 박스
      Text(briefing.briefingContent)
        .font(.subheadline)
        .foregroundColor(.secondary)
        .padding(.horizontal, 20)

      // 뉴스 섹션
      NewsListView(newsList: briefing.newsList)
    }
  }
}

#Preview {
  AIBriefingView(briefing: AIBriefing(
    baseDate: "2025-09-17T00:00:00.000Z",
    briefingContent: "AI가 분석한 종목 브리핑 내용",
    newsList: [
      NewsItem(
        link: "https://example.com/news1",
        summary: "뉴스 내용 미리보기 뉴스 내용 미리보기 뉴스 내용 미리보기 뉴스 내용 미리보기 뉴스 내용 미리보기",
        date: "2025-09-17T00:00:00.000Z"
      ),
      NewsItem(
        link: "https://example.com/news2",
        summary: "뉴스 내용 미리보기 뉴스 내용 미리보기 뉴스 내용 미리보기 뉴스 내용 미리보기 뉴스 내용 미리보기",
        date: "2025-09-16T00:00:00.000Z"
      ),
    ]
  ))
}
