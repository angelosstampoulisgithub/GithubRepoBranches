//
//  BranchesViewModel.swift
//  GithubRepoBranches
//
//  Created by Angelos Staboulis on 28/1/26.
//

import Foundation
@MainActor
final class BranchesViewModel: ObservableObject {
    @Published var branches: [Branch] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func loadBranches(owner: String, repo: String) {
        isLoading = true
        errorMessage = nil

        Task {
            do {
                branches = try await GitHubService.fetchBranches(
                    owner: owner,
                    repo: repo
                )
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}
