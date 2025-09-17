//
//  ContentViewModel.swift
//  AIDL
//
//  Created by Assistant on 9/16/25.
//

import SwiftUI

@MainActor
class ContentViewModel: ObservableObject {
    @Published var stocks: [Stock] = []
    @Published var expenseData: [ExpenseCategory] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let networkClient = NetworkClient()
    
    private let predefinedColors: [Color] = [.blue, .purple, .orange, .green, .red, .yellow, .pink, .cyan]
    
    func loadData() {
        Task {
            isLoading = true
            errorMessage = nil
            
            await withTaskGroup(of: Void.self) { group in
                group.addTask {
                    await self.loadStocks()
                }
                
                group.addTask {
                    await self.loadExpenseStats()
                }
            }
            
            isLoading = false
        }
    }
    
    private func loadStocks() async {
        do {
            // 1단계: 추천 주식 리스트 가져오기
            let recommendEndpoint = RecommendEndpoint()
            let recommendResponse = try await networkClient.requestValidated(recommendEndpoint)
            
            // 2단계: 각 주식의 가격 정보 가져오기
            var loadedStocks: [Stock] = []
            
            await withTaskGroup(of: Stock?.self) { group in
                for stockName in recommendResponse.stocks {
                    group.addTask {
                        do {
                            let priceEndpoint = PriceEndpoint(stockName: stockName)
                            let priceResponse = try await self.networkClient.requestValidated(priceEndpoint)
                            
                            // vsAmount로 전일 가격 계산: current - vsAmount = previous
                            let currentPrice = priceResponse.data.price.current
                            let vsAmount = priceResponse.data.price.vsAmount
                            let previousPrice = currentPrice - vsAmount
                            
                            return Stock(
                                name: stockName,
                                previousPrice: vsAmount, // UI에서는 등락폭을 previousPrice로 표시
                                currentPrice: currentPrice
                            )
                        } catch {
                            print("Error loading price for \(stockName): \(error)")
                            return nil
                        }
                    }
                }
                
                for await stock in group {
                    if let stock = stock {
                        loadedStocks.append(stock)
                    }
                }
            }
            
            self.stocks = loadedStocks
        } catch {
            self.errorMessage = "Failed to load stocks: \(error.localizedDescription)"
            print("Error loading stocks: \(error)")
        }
    }
    
    private func loadExpenseStats() async {
        do {
            let endpoint = StatsEndpoint()
            let response = try await networkClient.requestValidated(endpoint)
            self.expenseData = response.stats.enumerated().map { index, category in
                let color = predefinedColors[index % predefinedColors.count]
                return ExpenseCategory(
                    name: category.category,
                    percentage: category.percentage,
                    color: color
                )
            }
        } catch {
            self.errorMessage = "Failed to load expense stats: \(error.localizedDescription)"
            print("Error loading expense stats: \(error)")
        }
    }
}