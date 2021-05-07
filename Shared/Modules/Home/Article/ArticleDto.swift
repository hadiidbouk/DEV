//
//  ArticleDto.swift
//  DEV
//
//  Created by Hadi on 02/05/2021.
//

import DEVAPI

struct ArticleDto {
    let coverImageUrl: String?
    let publishedDateString: String
    let userName: String
    let userProfileImageUrl: String
    let title: String
    let tags: [TagItem]
    let reactionsCount: Int
    let commentsCount: Int
    let readingTimeMinutes: Int
}

extension ArticleDto {
    static func from(_ article: Article) -> Self {
        var tags = article.tagList.map { tag -> TagItem in
            var style = TagStyle()
            if let flareTag = article.flareTag, flareTag.name == tag {
                style = TagStyle(backgroundColor: .init(hex: flareTag.bgColorHex),
                                 textColor: .init(hex: flareTag.textColorHex))
            }
            return TagItem(text: tag, style: style)
        }

        if let flareTagIndex = tags.firstIndex(where: { $0.style.backgroundColor != .clear }) {
            let flareTag = tags.remove(at: flareTagIndex)
            tags.insert(flareTag, at: .zero)
        }

        let timeAgo = article.publishedAt?.timeAgo() ?? ""
        var publishedDateTimeString = article.readablePublishDate
        if !timeAgo.isEmpty {
            publishedDateTimeString += " (\(timeAgo))"
        }

        return ArticleDto(coverImageUrl: article.coverImage,
                          publishedDateString: publishedDateTimeString,
                          userName: article.user.name,
                          userProfileImageUrl: article.user.profileImage90,
                          title: article.title,
                          tags: tags,
                          reactionsCount: article.publicReactionsCount,
                          commentsCount: article.commentsCount,
                          readingTimeMinutes: article.readingTimeMinutes)
    }
}
