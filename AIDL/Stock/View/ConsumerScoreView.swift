import SwiftUI

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

#Preview {
  ConsumerScoreView(score: ConsumerMatchingScore(
    score: 95,
    content: "GPT스타일 소비 생활과 반영하다는 내용 등과 같이"
  ))
}
