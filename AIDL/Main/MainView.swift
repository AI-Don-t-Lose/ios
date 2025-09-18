//
//  MainView.swift
//  AIDL
//
//  Created by Jinyoung Kim on 9/12/25.
//

import Charts
import SwiftUI

struct MainView: View {
  let userName = "000"

  @StateObject private var viewModel = MainViewModel()

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 30) {
        VStack(alignment: .leading, spacing: 10) {
          HStack {
            VStack(alignment: .leading) {
              Text("안녕하세요")
                .font(.title2)
                .fontWeight(.bold)
              Text("\(userName)님!")
                .font(.title2)
                .fontWeight(.bold)
            }

            Spacer()
          }
        }

        VStack(alignment: .leading, spacing: 15) {
          HStack {
            Text("오늘의 추천 종목")
              .font(.title2)
              .fontWeight(.bold)

            Spacer()
          }

          VStack(spacing: 10) {
            ForEach(viewModel.stocks.indices, id: \.self) { index in
              HStack {
                Text(viewModel.stocks[index].name)
                  .font(.body)
                  .foregroundColor(.secondary)

                Spacer()

                HStack(spacing: 10) {
                  HStack {
                    if viewModel.stocks[index].previousPrice != 0 {
                      Image(systemName: "triangle.fill")
                        .rotationEffect(.degrees(viewModel.stocks[index].previousPrice > 0 ? 0 : 180))
                        .foregroundColor(viewModel.stocks[index].previousPrice > 0 ? .red : .blue)
                        .font(.caption)
                    }

                    Text(String(format: "%.0f", abs(viewModel.stocks[index].previousPrice)))
                      .font(.body)
                      .foregroundColor(
                        viewModel.stocks[index].previousPrice > 0 ? .red :
                          viewModel.stocks[index].previousPrice < 0 ? .blue : .black
                      )
                  }

                  Text(String(format: "%.0f", viewModel.stocks[index].currentPrice))
                    .font(.body)
                    .fontWeight(.semibold)
                }
              }
              .padding()
              .background(Color(.systemGray6))
              .cornerRadius(10)
            }
          }
        }

        VStack(alignment: .leading, spacing: 15) {
          HStack {
            Text("소비 통계")
              .font(.title2)
              .fontWeight(.bold)

            Spacer()
          }

          HStack {
            Spacer()

            VStack {
              ZStack {
                let total = viewModel.expenseData.reduce(0) { $0 + $1.percentage }

                ForEach(viewModel.expenseData.indices, id: \.self) { index in
                  let startAngle = viewModel.expenseData.prefix(index).reduce(0) { $0 + $1.percentage } / total
                  let endAngle = viewModel.expenseData.prefix(index + 1).reduce(0) { $0 + $1.percentage } / total

                  Circle()
                    .trim(from: startAngle, to: endAngle)
                    .stroke(viewModel.expenseData[index].color, lineWidth: 25)
                    .frame(width: 150, height: 150)
                    .rotationEffect(.degrees(-90))
                }

                Circle()
                  .fill(Color(.systemBackground))
                  .frame(width: 80, height: 80)
              }
              .padding(.bottom, 20)

              VStack(alignment: .leading, spacing: 8) {
                ForEach(viewModel.expenseData.indices, id: \.self) { index in
                  HStack {
                    Circle()
                      .fill(viewModel.expenseData[index].color)
                      .frame(width: 12, height: 12)

                    Text(viewModel.expenseData[index].name)
                      .font(.caption)
                      .foregroundColor(.secondary)

                    Spacer()

                    Text("\(Int(viewModel.expenseData[index].percentage))%")
                      .font(.caption)
                      .foregroundColor(.secondary)
                  }
                }
              }
            }
            Spacer()
          }
        }
      }
      .padding()
    }
    .onAppear {
      viewModel.loadData()
    }
    .overlay {
      if viewModel.isLoading {
        ProgressView("Loading...")
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .background(Color.black.opacity(0.1))
      }
    }
    .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
      Button("OK") {
        viewModel.errorMessage = nil
      }
    } message: {
      if let errorMessage = viewModel.errorMessage {
        Text(errorMessage)
      }
    }
  }
}
