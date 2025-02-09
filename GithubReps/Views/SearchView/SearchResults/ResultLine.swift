//
//  ResultLine.swift
//  GithubReps
//
//  Created by Антон Разгуляев on 06.02.2025.
//

import SwiftUI

struct ResultLine: View {
    var mainViewModel: MainViewModel
    let repository: RepositoryResponseModel
    let index: Int

    var body: some View {
        HStack(spacing: 16) {
            Text(index.description)
                .font(.subheadline)
            OwnerAvatar(avatarURL: repository.owner.avatarURL, avatarSize: 40, cornerRadius: 5)
            Text(repository.name)
                .lineLimit(2)
            Spacer(minLength: 1)
            if mainViewModel.favourites.contains(repository) {
                Image(systemName: "star.fill")
                    .foregroundStyle(.orange)
            }
        }
    }
}

#Preview {
    ResultLine(mainViewModel: MainViewModel(), repository: repositoryResponseModelMockData, index: 1)
}
