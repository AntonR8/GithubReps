//
//  ResultList.swift
//  GithubReps
//
//  Created by Антон Разгуляев on 06.02.2025.
//

import SwiftUI

struct ResultList: View {
    let result: [RepositoryResponseModel]
    var mainViewModel: MainViewModel
    var navigationTitle = "Результаты поиска"
    var sectionTitle = "Найдено"

    var body: some View {
            List {
                Section("\(sectionTitle) \(result.count) репозиториев:") { 
                    ForEach(Array(zip(result.indices, result)), id: \.0) { index, repository in
                        Button(action: {
                            mainViewModel.showFullRepositoryInfo(repositoryResponse: repository)
                        }) {
                            ResultLine(mainViewModel: mainViewModel, repository: repository, index: index+1)
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: false) {
                            if mainViewModel.favourites.contains(repository) {
                                Button("Удалить из избранного") {
                                    mainViewModel.removeFromFavourites(repository)
                                }
                                .tint(.red)
                            } else {
                                Button("Добавить в избранное") {
                                    mainViewModel.apendToFavourites(repository)
                                }
                                .tint(.orange)
                            }
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Link("Перейти на GitHub", destination: URL(string: repository.htmlURL) ?? URL(string: "http://github.com")!)
                                .tint(.purple)
                        }
                    }
                }
                    if result.count == 0 {
                          Text("Чтобы найти репозитории, откройте вкладку поиска и введите название или тематику нужного вам репозитория")
                            .foregroundStyle(.secondary)
                }
            }
            .onDisappear(perform: {
                mainViewModel.searchResultsTask?.cancel()
            })
        .navigationTitle(navigationTitle)
    }
}

#Preview {
    NavigationStack{
        ResultList(
            result: [
                repositoryResponseModelMockData,
                repositoryResponseModelMockData,
                repositoryResponseModelMockData
            ], mainViewModel: MainViewModel()
            )
    }
}
