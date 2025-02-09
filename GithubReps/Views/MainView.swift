//
//  ContentView.swift
//  GithubReps
//
//  Created by Антон Разгуляев on 06.02.2025.
//

import SwiftUI

struct MainView: View {
    @State var mainViewModel = MainViewModel()

    var body: some View {
        NavigationStack(path: $mainViewModel.path) {
            TabView(selection: $mainViewModel.tabSelection) {
                SearchView(mainViewModel: mainViewModel)
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Поиск")
                    }
                    .tag(1)
                FavouritesView(mainViewModel: mainViewModel)
                    .tabItem {
                        Image(systemName: "star")
                        Text("Избранные")
                    }
                        .tag(2)
                SettingsView(mainViewModel: mainViewModel)
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Настройки")
                    }
                    .navigationTitle("Настройки")
                    .tag(3)
            }
            .navigationTitle(mainViewModel.returnNavigationTitle())
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: [RepositoryResponseModel].self) { result in
                ResultList(result: result, mainViewModel: mainViewModel)
            }
            .navigationDestination(for: RepositoryModel.self) { repositoryInfo in
                RepositoryView(mainViewModel: mainViewModel, repository: repositoryInfo)
            }
        }
        .preferredColorScheme(mainViewModel.darkColorScheme ? .dark : ColorScheme(.unspecified))
    }
}


#Preview {
    MainView()
}
