//
//  Followers.swift
//  GithubFollowers
//
//  Created by Antriksh Singh on 10/05/24.
//

import Foundation


// MARK: - WelcomeElement
struct Followers: Codable {
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL: String
    let url: String
//    let gravatarID: String
//    let url, htmlURL, followersURL: String
//    let followingURL, gistsURL, starredURL: String
//    let subscriptionsURL, organizationsURL, reposURL: String
//    let eventsURL: String
//    let receivedEventsURL: String
//    let siteAdmin: Bool

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case url
//        case gravatarID = "gravatar_id"
//        case htmlURL = "html_url"
//        case followersURL = "followers_url"
//        case followingURL = "following_url"
//        case gistsURL = "gists_url"
//        case starredURL = "starred_url"
//        case subscriptionsURL = "subscriptions_url"
//        case organizationsURL = "organizations_url"
//        case reposURL = "repos_url"
//        case eventsURL = "events_url"
//        case receivedEventsURL = "received_events_url"
//        case siteAdmin = "site_admin"
    }
}


