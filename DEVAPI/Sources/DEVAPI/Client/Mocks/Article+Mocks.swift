//
//  File.swift
//  
//
//  Created by Hadi on 09/04/2021.
//

import Foundation

// swiftlint:disable all
public extension Article {
    static func mock(typeOf: String = "article",
                     id: Int = 660167,
                     title: String = "Why Choose Shopware for Building Your?",
                     description: String = "The B2B business market evolves day by day. Customer preferences rapidly change, prominent digital...",
                     readablePublishDate: String = "Apr  9",
                     slug: String = "why-choose-shopware-for-building-your-b2b-business-empire-1pi1",
                     path: String = "/dinarysgmbh/why-choose-shopware-for-building-your-b2b-business-empire-1pi1",
                     url: String = "https://dev.to/dinarysgmbh/why-choose-shopware-for-building-your-b2b-business-empire-1pi1",
                     commentsCount: Int = 0,
                     publicReactionsCount: Int = 0,
                     collectionId: Int? = nil,
                     publishedTimestamp: Date = .init(),
                     positiveReactionsCount: Int = 0,
                     coverImage: String? = nil,
                     socialImage: String = "https://dev.to/social_previews/article/660167.png",
                     canonicalUrl: String = "https://dev.to/dinarysgmbh/why-choose-shopware-for-building-your-b2b-business-empire-1pi1",
                     createdAt: Date = .init(),
                     editedAt: Date? = nil,
                     crosspostedAt: Date? = nil,
                     publishedAt: Date? = nil,
                     lastCommentAt: Date? = nil,
                     tagList: [String] = ["ecommerce","b2b","businessgrowth","shopware"],
                     tags: String = "ecommerce, b2b, businessgrowth, shopware",
                     readingTimeMinutes: Int = 6,
                     user: User = .mock(),
                     organization: Organization? = nil,
                     flareTag: FlareTag? = nil) -> Article {
        Article(typeOf: typeOf, id: id, title: title, description: description, readablePublishDate: readablePublishDate, slug: slug, path: path, url: url, commentsCount: commentsCount, publicReactionsCount: publicReactionsCount, collectionId: collectionId, publishedTimestamp: publishedTimestamp, positiveReactionsCount: positiveReactionsCount, coverImage: coverImage, socialImage: socialImage, canonicalUrl: canonicalUrl, createdAt: createdAt, editedAt: editedAt, crosspostedAt: crosspostedAt, publishedAt: publishedAt, lastCommentAt: lastCommentAt, tagList: tagList, tags: tags, readingTimeMinutes: readingTimeMinutes, user: user, organization: organization, flareTag: flareTag)
    }
}

public extension Article.User {
    static func mock(name: String = "DinarysGmbH",
                     username: String = "dinarysgmbh",
                     twitterUsername: String? = "DinarysGmbH",
                     githubUsername: String? = nil,
                     websiteUrl: String? = nil,
                     profileImage: String = "https://res.cloudinary.com/practicaldev/image/fetch/s--ogIESgWu--/c_fill,f_auto,fl_progressive,h_640,q_auto,w_640/https://dev-to-uploads.s3.amazonaws.com/uploads/user/profile_image/300149/5df0f30d-fe2f-414b-b351-9eb3feba59a2.jpg",
                     profileImage90: String = "https://res.cloudinary.com/practicaldev/image/fetch/s--mdNXJhS1--/c_fill,f_auto,fl_progressive,h_90,q_auto,w_90/https://dev-to-uploads.s3.amazonaws.com/uploads/user/profile_image/300149/5df0f30d-fe2f-414b-b351-9eb3feba59a2.jpg") -> Article.User {
        Article.User(name: name, username: username, twitterUsername: twitterUsername, githubUsername: githubUsername, websiteUrl: websiteUrl, profileImage: profileImage, profileImage90: profileImage90)
    }
}
