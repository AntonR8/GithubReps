//
//  SearchingProgress.swift
//  GithubReps
//
//  Created by Антон Разгуляев on 09.02.2025.
//

import SwiftUI

struct SearchingProgress: ViewModifier {
    @Bindable var mainViewModel: MainViewModel

    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $mainViewModel.showProgressView) {
                VStack {
                    Spacer()
                    if mainViewModel.repositoriesFound > 0 {
                        Gauge(value: Double(mainViewModel.currentDownLoadingRepository), in: 0...Double(mainViewModel.repositoriesFound+100)) {
                            Text("Загружаю результаты: \(mainViewModel.currentDownLoadingRepository) из \(mainViewModel.repositoriesFound)")
                        }
                        .padding(32)
                    } else {
                        Text("Ожидаю ответ сервера...")
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    Button("Отменить", role: .destructive) {
                        mainViewModel.searchResultsTask?.cancel()
                        mainViewModel.showProgressView = false
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle)
                    .padding(.vertical, 40)
                }
            }
    }
}


extension View {
    func searchingProgressFullScreenCover(mainViewModel: MainViewModel) -> some View {
        modifier(SearchingProgress(mainViewModel: mainViewModel))
    }
}
