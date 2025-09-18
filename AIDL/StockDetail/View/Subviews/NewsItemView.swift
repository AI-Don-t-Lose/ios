import SwiftUI

// MARK: - News Item View

struct NewsItemView: View {
  let newsItem: NewsItem

  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      Text(newsItem.date)
        .font(.caption)
        .fontWeight(.medium)
        .foregroundColor(.primary)

      Text(newsItem.summary)
        .font(.caption)
        .foregroundColor(.secondary)
        .lineLimit(2)
        .multilineTextAlignment(.leading)
    }
    .padding(.horizontal, 20)
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

#Preview {
  NewsListView(newsList: [
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
  ])
}
