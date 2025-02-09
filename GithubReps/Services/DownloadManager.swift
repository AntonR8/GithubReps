//
//  DownloadManager.swift
//  GithubReps
//
//  Created by Антон Разгуляев on 08.02.2025.
//

import SwiftUI

enum FetcherError: Error {
    case invalidURL
    case badStatusCode(Int)
    case badServerResponse
}

class DownloadManager {
    static let shared = DownloadManager()
    
    private init() {}


     func createRepositoryRequest(query: String, pageNumber: Int) -> String {
        return "https://api.github.com/search/repositories?q=\(query)&per_page=100&page=\(pageNumber)"
    }

    func createOwnerRequest(query: String) -> String {
        return "https://api.github.com/users/\(query)"
    }

    func returnResponse(requestString: String) async throws -> Data {
        guard let url = URL(string: requestString) else { throw FetcherError.invalidURL }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let (receivedData, response) = try await URLSession.shared.data(for: request)
        if let httpResponse = response as? HTTPURLResponse {
            print("Server returned status code: \(httpResponse.statusCode)")
            if httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 {
                return receivedData
            } else {
                throw FetcherError.badStatusCode(httpResponse.statusCode)
            }
        }
        throw FetcherError.badServerResponse
    }

    func decodeRepositoryResponse(receivedData: Data) throws -> ResponseModel {
        let response = try JSONDecoder().decode(ResponseModel.self, from: receivedData)
        return response
    }

    func decodeOwnerResponse(receivedData: Data) throws -> OwnerResponse {
        let response = try JSONDecoder().decode(OwnerResponse.self, from: receivedData)
        return response
    }
}
