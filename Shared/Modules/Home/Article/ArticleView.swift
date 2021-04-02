//
//  ArticleView.swift
//  DEV
//
//  Created by Hadi on 31/03/2021.
//

import SwiftUI

private typealias Layout = ArticleView.Layout

extension ArticleView {
    enum Layout {
        static let userNameAndDateSpacing: CGFloat = 3
        static let imageAndNameSpacing: CGFloat = 8
    }
}

struct ArticleView: View {
    var body: some View {
        VStack(alignment: .leading) {
            UserInfoView()

            Group {
                TitleView()
                TagListView(tags: [.init(text: "challenge"),
                                   .init(text: "programming"),
                                   .init(text: "productivity"),
                                   .init(text: "codenewbie"),
                                   .init(text: "tutorial")])
                ReactionsAndCommentsView(reactionsCount: 17, commentsCount: 3)
            }
            .padding(.leading, Layout.viewsLeadingPadding)
            .padding(.top, Layout.viewsTopPadding)
        }
        .padding(Layout.contentPadding)
        .applyBackground(.appPrimary)
        .applyBorder()
    }
}

private struct UserInfoView: View {
    var body: some View {
        HStack(alignment: .top, spacing: Layout.imageAndNameSpacing) {
            RoundedImageView(image: Image("user"))
                .frame(width: Layout.imageSize, height: Layout.imageSize)

            VStack(alignment: .leading, spacing: Layout.userNameAndDateSpacing) {
                Text("Leonardo J. 👨🏻‍💻")
                    .font(.system(size: Layout.userNameFontSize))
                    .fontWeight(.medium)
                    .foregroundColor(.secondaryText)

                Text("Aug 5 '20")
                    .font(.system(size: Layout.dateFontSize))
                    .font(.body)
                    .foregroundColor(.tertiaryText)
            }

            Spacer()
        }
    }
}

private struct TitleView: View {
    var body: some View {
        #if os(iOS)
        Text("My favorite resources being a freelancer as a side hustle 💎")
        .font(.system(size: Layout.titleFontSize, weight: .bold, design: .default))
        #else
        TextButton(text: "My favorite resources being a freelancer as a side hustle 💎") {
            print("Pressed.")
        }
        .font(.system(size: Layout.titleFontSize, weight: .bold, design: .default))
        #endif
    }
}

private struct ReactionsAndCommentsView: View {
    let reactionsCount: Int
    let commentsCount: Int

    var body: some View {
        HStack {
            label(title: title(from: reactionsCount, suffix: "reactions"), image: "reactions")
            label(title: title(from: commentsCount, suffix: "comments"), image: "comments")
        }
    }

    @ViewBuilder func label(title: String, image: String) -> some View {
        Label(
            title: {
                Text(title)
                    .foregroundColor(.secondaryText)
                    .font(.system(size: Layout.reactionsAndCommentsTextFontSize))
            },
            icon: {
                Image(image)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.secondaryText)
                    .frame(width: Layout.reactionsAndCommentsImageSize,
                           height: Layout.reactionsAndCommentsImageSize)
            }
        )
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

#if DEBUG
struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView()
            .padding()
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
            .padding()
    }
}
#endif
