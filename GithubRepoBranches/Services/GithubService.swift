//
//  GithubService.swift
//  GithubRepoBranches
//
//  Created by Angelos Staboulis on 28/1/26.
//

import Foundation
final class GitHubService {
    static func fetchBranches(
        owner: String,
        repo: String
    ) async throws -> [Branch] {

        let urlString = "https://api.github.com/repos/\(owner)/\(repo)/branches"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let http = response as? HTTPURLResponse,
              http.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode([Branch].self, from: data)
    }
}
