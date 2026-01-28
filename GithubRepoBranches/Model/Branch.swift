//
//  Branch.swift
//  GithubRepoBranches
//
//  Created by Angelos Staboulis on 28/1/26.
//

import Foundation
struct Branch: Identifiable, Decodable {
    let name: String

    var id: String { name }
}
