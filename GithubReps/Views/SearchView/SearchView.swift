//
//  SearchView.swift
//  GithubReps
//
//  Created by Антон Разгуляев on 06.02.2025.
//

import SwiftUI

struct SearchView: View {
    @State private var currentQuery: String = ""
    @Bindable var mainViewModel: MainViewModel
    @FocusState var isFocused: Bool

    var body: some View {
        ZStack {
            SearchViewBackGround()
                .onTapGesture {
                    isFocused = false
                }
            VStack {
                Text("Искать репозиторий github.com")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                QueryFieldView(
                    currentQuery: $currentQuery,
                    isFocused: $isFocused,
                    onSubmitAction: {
                        mainViewModel.searchButtonPushed(query: currentQuery)
                    } )
                SearchButton(action: {
                    mainViewModel.searchButtonPushed(query: currentQuery)
                }, isDisabled: currentQuery.isEmpty)
            }
            .padding()
        }
        .searchingProgressFullScreenCover(mainViewModel: mainViewModel)
        .connectionTroublesSheet(mainViewModel: mainViewModel)
    }
}

#Preview {
    NavigationStack{
        SearchView(mainViewModel: MainViewModel())
    }
}
