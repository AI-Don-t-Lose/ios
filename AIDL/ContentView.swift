//
//  ContentView.swift
//  AIDL
//
//  Created by Jinyoung Kim on 9/12/25.
//

import SwiftUI
import Charts

struct Stock {
    let name: String
    let previousPrice: Double
    let currentPrice: Double
}

struct ExpenseCategory {
    let name: String
    let percentage: Double
    let color: Color
}

struct ContentView: View {
    let userName = "000"
    
    let stocks = [
        Stock(name: "추천 종목 1", previousPrice: 520, currentPrice: 17350),
        Stock(name: "추천 종목 2", previousPrice: -490, currentPrice: 12300),
        Stock(name: "추천 종목 3", previousPrice: 1860, currentPrice: 40653)
    ]
    
    let expenseData = [
        ExpenseCategory(name: "현대 주유소", percentage: 40, color: .blue),
        ExpenseCategory(name: "Key title goes here", percentage: 30, color: .purple),
        ExpenseCategory(name: "Key title goes here", percentage: 20, color: .orange),
        ExpenseCategory(name: "Key title goes here", percentage: 10, color: .green)
    ]
    
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
                        ForEach(stocks.indices, id: \.self) { index in
                            HStack {
                                Text(stocks[index].name)
                                    .font(.body)
                                    .foregroundColor(.secondary)
                                
                                Spacer()
                                
                                HStack(spacing: 10) {
                                    HStack {
                                        Image(systemName: stocks[index].previousPrice > 0 ? "triangle.fill" : "triangle.fill")
                                            .rotationEffect(.degrees(stocks[index].previousPrice > 0 ? 0 : 180))
                                            .foregroundColor(stocks[index].previousPrice > 0 ? .blue : .red)
                                            .font(.caption)
                                        
                                        Text(String(format: "%.0f", abs(stocks[index].previousPrice)))
                                            .font(.body)
                                            .foregroundColor(stocks[index].previousPrice > 0 ? .blue : .red)
                                    }
                                    
                                    Text(String(format: "%.0f", stocks[index].currentPrice))
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
                                let total = expenseData.reduce(0) { $0 + $1.percentage }
                                
                                ForEach(expenseData.indices, id: \.self) { index in
                                    let startAngle = expenseData.prefix(index).reduce(0) { $0 + $1.percentage } / total
                                    let endAngle = expenseData.prefix(index + 1).reduce(0) { $0 + $1.percentage } / total
                                    
                                    Circle()
                                        .trim(from: startAngle, to: endAngle)
                                        .stroke(expenseData[index].color, lineWidth: 25)
                                        .frame(width: 150, height: 150)
                                        .rotationEffect(.degrees(-90))
                                }
                                
                                Circle()
                                    .fill(Color(.systemBackground))
                                    .frame(width: 80, height: 80)
                            }
                            .padding(.bottom, 20)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                ForEach(expenseData.indices, id: \.self) { index in
                                    HStack {
                                        Circle()
                                            .fill(expenseData[index].color)
                                            .frame(width: 12, height: 12)
                                        
                                        Text(expenseData[index].name)
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                        
                                        Spacer()
                                        
                                        Text("\(Int(expenseData[index].percentage))%")
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
    }
}

#Preview {
    ContentView()
}
