//
//  ContentView.swift
//  GithubRepoBranches
//
//  Created by Angelos Staboulis on 28/1/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = BranchesViewModel()
    @State private var owner = "apple"
    @State private var repo = "container"
    var body: some View {
        NavigationStack {
           
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading branches…")
                } else if let error = viewModel.errorMessage {
                    VStack(spacing: 12) {
                        Image(systemName: "exclamationmark.triangle")
                        Text(error)
                            .multilineTextAlignment(.center)
                    }
                } else {
                    header()
                    List(viewModel.branches) { branch in
                        Text(branch.name)
                    }
                }
            }
            .navigationTitle("Branches")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                viewModel.loadBranches(
                    owner: owner,
                    repo: repo
                )
            }
        }
    }
    @ViewBuilder
    private func header() -> some View{
            VStack{
                Text("Enter Owner").frame(maxWidth:.infinity,alignment: .leading)
                TextField("",text: $owner).frame(maxWidth:.infinity,alignment: .leading)
                Text("Enter Repository")
                .frame(maxWidth:.infinity,alignment: .leading)
                .textInputAutocapitalization(.never)
                TextField("",text: $repo)
                .textInputAutocapitalization(.never)
                .frame(maxWidth:.infinity,alignment: .leading)
                .onSubmit {
                    Task{
                        viewModel.loadBranches(
                            owner: owner,
                            repo: repo
                        )
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
