//
//  Article.swift
//  
//
//  Created by Hadi on 07/04/2021.
//

import Foundation

public struct Article: Identifiable, Decodable, Equatable, Hashable {
    public let typeOf: String
    public let id: Int
    public let title: String
    public let description: String
    public let readablePublishDate: String
    public let slug: String
    public let path: String
    public let url: String
    public let commentsCount: Int
    public let publicReactionsCount: Int
    public let collectionId: Int?
    public let publishedTimestamp: Date
    public let positiveReactionsCount: Int
    public let coverImage: String?
    public let socialImage: String
    public let canonicalUrl: String
    public let createdAt: Date
    public let editedAt: Date?
    public let crosspostedAt: Date?
    public let publishedAt: Date?
    public let lastCommentAt: Date?
    public let tagList: [String]
    public let tags: String
    public let user: User
    public let organization: Organization?
    public let flareTag: FlareTag?
}

public extension Article {
    struct User: Decodable, Equatable, Hashable {
        public let name: String
        public let username: String
        public let twitterUsername: String?
        public let githubUsername: String?
        public let websiteUrl: String?
        public let profileImage: String
        public let profileImage90: String
    }

    struct Organization: Decodable, Equatable, Hashable {
        public let name: String
        public let username: String
        public let slug: String
        public let profileImage: String
        public let profileImage90: String
    }

    struct FlareTag: Decodable, Equatable, Hashable {
        public let name: String
        public let bgColorHex: String
        public let textColorHex: String
    }
}
