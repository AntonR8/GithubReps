//
//  FavouritesView.swift
//  GithubReps
//
//  Created by Антон Разгуляев on 06.02.2025.
//

import SwiftUI

struct FavouritesView: View {
    var mainViewModel: MainViewModel

    var body: some View {
        ResultList(result: mainViewModel.favourites, mainViewModel: mainViewModel, navigationTitle: "Избранное", sectionTitle: "Сохранено")
    }
}

#Preview {
    NavigationStack{
        FavouritesView(mainViewModel: MainViewModel())
    }
}
