//
//  MainViewModel.swift
//  GithubReps
//
//  Created by Антон Разгуляев on 06.02.2025.
//

import SwiftUI
import Observation


@Observable
class MainViewModel {
    var tabSelection = 1
    var darkColorScheme = true
    var path = NavigationPath()
    var showProgressView = false
    var showConnectionProblems = false
    var repositoriesFound: Int = 0
    var currentDownLoadingRepository: Int = 0
    let downloadManager = DownloadManager.shared
    var searchResultsTask: Task<(), Never>?

    var favourites: [RepositoryResponseModel] = [] {
        didSet { saveFavourites() }
    }

    init() {
        loadFavourites()
    }


    // navigation:
    func returnNavigationTitle() -> String {
        switch tabSelection {
        case 1: return "Поиск"
        case 2: return "Избранное"
        case 3: return "Настройки"
        default: return ""
        }
    }


    // функции поиска:
    func searchButtonPushed(query: String) {
        repositoriesFound = 0
        currentDownLoadingRepository = 0
        showProgressView = true
        self.searchResultsTask = Task {
            do {
                async let response = try await findRepositories(query: query)
                let result = try await response
                path.append(result)
                showProgressView = false
            } catch {
                searchResultsTask?.cancel()
                showProgressView = false
                showConnectionProblems = true
            }
        }
    }

    private func getNumberOfResults(query: String) async throws -> Int {
        let request = downloadManager.createRepositoryRequest(query: query, pageNumber: 1)
        let receivedData = try await downloadManager.returnResponse(requestString: request)
        let response = try downloadManager.decodeRepositoryResponse(receivedData: receivedData)
        return response.totalCount
    }

    private func findRepositories(query: String) async throws -> [RepositoryResponseModel] {
        var repositories: [RepositoryResponseModel] = []
        repositoriesFound = try await getNumberOfResults(query: query)
        for page in 1...repositoriesFound/100 + 1 {
            let request = downloadManager.createRepositoryRequest(query: query, pageNumber: page)
            let receivedData = try await downloadManager.returnResponse(requestString: request)
            let response = try downloadManager.decodeRepositoryResponse(receivedData:  receivedData)
            repositories.append(contentsOf: response.items)
            await MainActor.run {
                withAnimation(.bouncy) {
                    currentDownLoadingRepository += 100
                }
            }
        }
        return repositories
    }


    private func searchOwnerInfo(ownerName: String) async throws -> OwnerResponse {
        let request = downloadManager.createOwnerRequest(query: ownerName)
        let receivedData = try await downloadManager.returnResponse(requestString: request)
        let response = try downloadManager.decodeOwnerResponse(receivedData: receivedData)
        return response
    }


    func showFullRepositoryInfo(repositoryResponse: RepositoryResponseModel) {
        Task {
            async let response = try? await searchOwnerInfo(ownerName: repositoryResponse.owner.login)
            let result = await response
            if let result {
                let repositoryInfo = RepositoryModel(
                    name: repositoryResponse.name,
                    htmlURL: repositoryResponse.htmlURL,
                    description: repositoryResponse.description,
                    login: repositoryResponse.owner.login,
                    avatarURL: repositoryResponse.owner.avatarURL,
                    ownerName: result.name,
                    email: result.email
                )
                path.append(repositoryInfo)
            }
        }
    }

    //функции избранного:
    private func saveFavourites() {
        if let encodedData = try? JSONEncoder().encode(favourites) {
            UserDefaults.standard.setValue(encodedData, forKey: "favourites")
        }
    }

    private func loadFavourites() {
        guard
            let favouritesData = UserDefaults.standard.data(forKey: "favourites"),
            let savedFavourites = try? JSONDecoder().decode([RepositoryResponseModel].self, from: favouritesData)
        else { return }
        self.favourites = savedFavourites
    }

    func toggleFavourite(_ repository: RepositoryModel) {
        if let index = favourites.firstIndex(where: {$0.htmlURL == repository.htmlURL}) {
            favourites.remove(at: index)
        } else {
            let repositoryResponseInstance = RepositoryResponseModel(
                name: repository.name,
                owner: RepositoryResponseModel.Owner(login: repository.login, avatarURL: repository.avatarURL),
                htmlURL: repository.htmlURL,
                description: repository.description
            )
            favourites.append(repositoryResponseInstance)
        }
    }

    func apendToFavourites(_ repository: RepositoryResponseModel) {
        favourites.append(repository)
    }

    func removeFromFavourites(_ repository: RepositoryResponseModel) {
        if let index = favourites.firstIndex(where: {$0.htmlURL == repository.htmlURL}) {
            favourites.remove(at: index)
        }
    }
}
