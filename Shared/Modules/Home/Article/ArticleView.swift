//
//  ArticleView.swift
//  DEV
//
//  Created by Hadi on 31/03/2021.
//

import DEVAPI
import SwiftUI

private typealias Layout = ArticleView.Layout

extension ArticleView {
    enum Layout {
        static let userNameAndDateSpacing: CGFloat = 3
        static let imageAndNameSpacing: CGFloat = 8
    }
}

struct ArticleView: View {
    let article: Article
    @Binding var isRedacted: Bool

    var body: some View {
        VStack {
            if let coverImage = article.coverImage {
                RemoteImageView(imageUrl: coverImage)
            }

            VStack(alignment: .leading) {
                UserInfoView(name: article.user.name,
                             date: article.readablePublishDate,
                             image: article.user.profileImage90)

                Group {
                    TitleView(title: article.title)
                        .redactable()

                    TagListView(tags: article.tagList.map { TagItem(text: $0) })

                    HStack {
                        ReactionsAndCommentsView(reactionsCount: article.publicReactionsCount,
                                                 commentsCount: article.commentsCount)

                        Spacer()

                        SaveView(readingTime: article.readingTimeMinutes)
                            .redacted(reason: isRedacted ? .hidden : [])
                    }
                }
                .padding(.leading, Layout.viewsLeadingPadding)
                .padding(.top, Layout.viewsTopPadding)
            }
            .padding(Layout.contentPadding)
        }
        .applyBackground(.appPrimary)
        .applyBorder()
        .redacted(reason: isRedacted ? .animatedPlaceholder : [])
    }
}

private struct UserInfoView: View {
    let name: String
    let date: String
    let image: String

    var body: some View {
        HStack(alignment: .top, spacing: Layout.imageAndNameSpacing) {
            RemoteImageView(imageUrl: image)
                .roundedBorder()
                .frame(width: Layout.imageSize, height: Layout.imageSize)
                .redactable(shapeType: .circle)

            VStack(alignment: .leading, spacing: Layout.userNameAndDateSpacing) {
                Text(name)
                    .font(.system(size: Layout.userNameFontSize))
                    .fontWeight(.medium)
                    .foregroundColor(.secondaryText)
                    .redactable()

                Text(date)
                    .font(.system(size: Layout.dateFontSize))
                    .font(.body)
                    .foregroundColor(.tertiaryText)
                    .redactable()
            }

            Spacer()
        }
    }
}

private struct TitleView: View {
    let title: String

    var body: some View {
        let action = Platform.is(.macOS) ? {
            // do Something
        } : {}

        DEVButton(title,
                  config: {
                    $0.forgroundColor = .primaryText
                    $0.selectedForgroundColor = .accent
                    $0.textFont = .system(size: Layout.titleFontSize, weight: .bold, design: .default)
                    $0.imageSize = Layout.reactionsAndCommentsImageSize
                    $0.clickable = Platform.is(.macOS) ? true : false
                  },
                  action: action)
    }
}

private struct ReactionsAndCommentsView: View {
    let reactionsCount: Int
    let commentsCount: Int

    var body: some View {
        let config: (inout DEVButtonConfig) -> Void = {
            $0.forgroundColor = .secondaryText
            $0.selectedForgroundColor = .tertiaryText
            $0.textFont = Font.system(size: Layout.reactionsAndCommentsTextFontSize)
            $0.imageSize = Layout.reactionsAndCommentsImageSize
            $0.clickable = Platform.is(.macOS) ? true : false
        }

        HStack {
            DEVButton(title(from: reactionsCount, suffix: "reactions"),
                      imageName: "reactions",
                      config: config)
                .redactable()

            DEVButton(title(from: commentsCount, suffix: "comments"),
                      imageName: "comments",
                      config: config)
                .redactable()
        }
    }

    func title(from count: Int, suffix: String) -> String {
        switch Platform.current {
        case .iPadOS, .macOS:
            return "\(count) \(suffix)"
        case .iOS:
            return "\(count)"
        }
    }
}

private struct SaveView: View {
    let readingTime: Int

    var body: some View {
        HStack(spacing: Layout.minReadAndSaveButtonSpacing) {
            Text("\(readingTime) min read")
                .foregroundColor(.tertiaryText)
                .font(.system(size: Layout.minReadFontSize))

            DEVButton("Save",
                      config: {
                        $0.forgroundColor = .secondaryText
                        $0.backgroundColor = .appSecondary
                        $0.selectedBackgroundColor = .appTertiary
                        $0.contentPadding = Layout.saveButtonContentPadding
                        $0.textFont = .system(size: Layout.saveButtonFontSize)
                      },
                      action: {

                      })
        }
        .redactable()
    }
}

#if DEBUG
struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(article: .mock(), isRedacted: .constant(false))
            .padding()
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(title: "This is a title")
            .padding()
    }
}

struct ReactionsAndCommentsView_Previews: PreviewProvider {
    static var previews: some View {
        ReactionsAndCommentsView(reactionsCount: 12,
                                 commentsCount: 37)
            .padding()
    }
}

struct SaveView_Previews: PreviewProvider {
    static var previews: some View {
        SaveView(readingTime: 3)
            .padding()
    }
}

#endif
