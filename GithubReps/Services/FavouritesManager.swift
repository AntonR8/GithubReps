//
//  FavouritesManager.swift
//  GithubReps
//
//  Created by Антон Разгуляев on 09.02.2025.
//

import SwiftUI

class FavouritesManager {
    static let shared = FavouritesManager()

    private init() {}


    func loadFavourites() -> [RepositoryResponseModel] {
        guard
            let favouritesData = UserDefaults.standard.data(forKey: "favourites"),
            let savedFavourites = try? JSONDecoder().decode([RepositoryResponseModel].self, from: favouritesData)
        else { return [] }
        return savedFavourites
    }

    private func saveFavourites(favourites: [RepositoryResponseModel]) {
        if let encodedData = try? JSONEncoder().encode(favourites) {
            UserDefaults.standard.setValue(encodedData, forKey: "favourites")
        }
    }

    func addToFavourites(repository: RepositoryModel) {
        var favourites = loadFavourites()
        let repositoryResponseInstance = RepositoryResponseModel(
            name: repository.name,
            owner: RepositoryResponseModel.Owner(login: repository.login, avatarURL: repository.avatarURL),
            htmlURL: repository.htmlURL,
            description: repository.description
        )
        favourites.append(repositoryResponseInstance)
        saveFavourites(favourites: favourites)
    }

    func addToFavourites(repository: RepositoryResponseModel) {
        var favourites = loadFavourites()
        favourites.append(repository)
        saveFavourites(favourites: favourites)
    }

    func checkIfIsFavourite(repository: RepositoryResponseModel) -> Bool {
        let favourites = loadFavourites()
        return favourites.contains(repository)
    }

    func checkIfIsFavourite(repository: RepositoryModel) -> Bool {
        let favourites = loadFavourites()
        return favourites.firstIndex(where: {$0.htmlURL == repository.htmlURL}) != nil
    }

    func removeFromFavourites(repository: RepositoryResponseModel) {
        var favourites = loadFavourites()
        if let index = favourites.firstIndex(where: {$0.htmlURL == repository.htmlURL}) {
            favourites.remove(at: index)
            saveFavourites(favourites: favourites)
        }
    }

    func removeFromFavourites(repository: RepositoryModel) {
        var favourites = loadFavourites()
        if let index = favourites.firstIndex(where: {$0.htmlURL == repository.htmlURL}) {
            favourites.remove(at: index)
            saveFavourites(favourites: favourites)
        }
    }

    func toggleFavourite(repository: RepositoryModel) {
        if checkIfIsFavourite(repository: repository) {
            removeFromFavourites(repository: repository)
        } else {
            addToFavourites(repository: repository)
        }
    }
}
