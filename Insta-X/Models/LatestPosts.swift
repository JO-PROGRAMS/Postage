//
//  LatestPosts.swift
//  Insta-X
//
//  Created by Youssef Osama on 04/12/2020.
//

import Foundation

// MARK: - SignInModel
struct LatestPosts: Codable {
    let status, message: String
    let data: [Datum]
    let pagination: Pagination
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int
    let type: String
    let user: User
    let content: String?
    let file: String
    let isLiked, isFeatured, viewsCount, commentsCount: Int
    let likesCount, sharesCount: Int

    enum CodingKeys: String, CodingKey {
        case id, type, user, content, file
        case isLiked = "is_liked"
        case isFeatured = "is_featured"
        case viewsCount = "views_count"
        case commentsCount = "comments_count"
        case likesCount = "likes_count"
        case sharesCount = "shares_count"
    }
}

// MARK: - User
struct User: Codable {
    let id: Int
    let username: String
    let image: String
}

// MARK: - Pagination
struct Pagination: Codable {
    let total, lastPage, perPage, currentPage: Int
}
