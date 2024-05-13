//
//  UserDetails.swift
//  GithubFollowers
//
//  Created by Antriksh Singh on 12/05/24.
//

import Foundation

struct UserDetails: Codable {
    let public_repos: Int
    let public_gists: Int
    let company : String
    let location : String
    let followers: Int
    let following: Int
}
