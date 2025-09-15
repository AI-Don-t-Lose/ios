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

      Text(newsItem.content)
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
      date: "2025.08.28 Yahoo News",
      content: "뉴스 내용 미리보기 뉴스 내용 미리보기 뉴스 내용 미리보기 뉴스 내용 미리보기 뉴스 내용 미리보기"
    ),
    NewsItem(
      date: "2025.08.27 Y News",
      content: "뉴스 내용 미리보기 뉴스 내용 미리보기 뉴스 내용 미리보기 뉴스 내용 미리보기 뉴스 내용 미리보기"
    ),
  ])
}
