//
//  RepositoryView.swift
//  GithubReps
//
//  Created by Антон Разгуляев on 06.02.2025.
//

import SwiftUI

struct RepositoryView: View {
    var mainViewModel: MainViewModel
    let repository: RepositoryModel

    var body: some View {
        ScrollView {
            VStack {
                OwnerAvatar(avatarURL: repository.avatarURL, avatarSize: 100, cornerRadius: 50)
                Text(repository.ownerName ?? repository.login)
                    .foregroundStyle(.secondary)
                Text(repository.name)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding()
                Text("Описание:")
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(repository.description ?? "Описание отсутствует")
                    .frame(maxWidth: .infinity, alignment: .leading)

                if let email = repository.email {
                    Link(destination: URL(string: "mailto:\(email)")!) {
                        Label(email, systemImage: "envelope")
                            .padding(.vertical)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                Link("Перейти на GitHub", destination: URL(string: repository.htmlURL)!)
                    .buttonBorderShape(.roundedRectangle)
                    .buttonStyle(.borderedProminent)
                    .tint(Color.purple.gradient)
                    .padding()
            }
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    mainViewModel.toggleFavourite(repository)
                } label: {
                    Image(systemName: (mainViewModel.favourites.firstIndex(where: {$0.htmlURL == repository.htmlURL}) != nil) ? "star.fill" : "star")
                        .foregroundStyle(.orange)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        RepositoryView(mainViewModel: MainViewModel(), repository: repositoryModelMockData)
    }
}
