//
//  ResponseModel.swift
//  GithubReps
//
//  Created by Антон Разгуляев on 07.02.2025.
//


import Foundation

//   https://api.github.com/search/repositories?q=imagegenerator
struct ResponseModel: Codable, Hashable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [RepositoryResponseModel]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}


struct RepositoryResponseModel: Codable, Hashable {
    let name: String
    let owner: Owner
    let htmlURL: String
    let description: String?

    enum CodingKeys: String, CodingKey {
        case name
        case owner
        case htmlURL = "html_url"
        case description = "description"
    }

    struct Owner: Codable, Hashable {
        let login: String
        let avatarURL: String

        enum CodingKeys: String, CodingKey {
            case login
            case avatarURL = "avatar_url"
        }
    }
}

let repositoryResponseModelMockData = RepositoryResponseModel(
    name: "ansible-openwisp2-imagegenerator",
    owner: RepositoryResponseModel.Owner(
        login: "ansible",
        avatarURL: "https://avatars.githubusercontent.com/u/14449?v=4"
    ), htmlURL: "https://avatars.githubusercontent.com/u/14449?v=4",
    description: nil
)

// https://api.github.com/users/openwisp
struct OwnerResponse: Codable {
    let avatarURL: String
    let email: String?

    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case email
    }
}


// Структура, которая содержит в себе и данные репозитория и данные владельца (email)
struct RepositoryModel: Codable, Hashable {
    let name: String
    let htmlURL: String
    let description: String?
    let login: String
    let avatarURL: String
    let email: String?
}

let repositoryModelMockData = RepositoryModel(
    name: "ansible-openwisp2-imagegenerator",
    htmlURL: "https://github.com/openwisp/ansible-openwisp2-imagegenerator",
    description: "Automatically build several openwisp2 firmware images for different organizations while keeping track of their differences", login: "openwisp",
    avatarURL: "https://avatars.githubusercontent.com/u/1150243?v=4",
    email: "support@openwisp.io"
)
