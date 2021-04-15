//
//  Layout+Extensions.swift
//  DEV (iOS)
//
//  Created by Hadi on 29/03/2021.
//

import CoreGraphics

extension AppSideBarView.Layout {
    static let fontSize: CGFloat = 20
    static let buttonsSpacing: CGFloat = 35
    static let imageSize: CGFloat = 26
}

extension ArticleView.Layout {
    static let contentPadding: CGFloat = Platform.is(.iPadOS) ? 30 : 15
    static let titleFontSize: CGFloat = Platform.is(.iPadOS) ? 30 : 16
    static let imageSize: CGFloat = Platform.is(.iPadOS) ? 50 : 40
    static let userNameFontSize: CGFloat = Platform.is(.iPadOS) ? 20 : 14
    static let dateFontSize: CGFloat = Platform.is(.iPadOS) ? 17 : 11
    static let reactionsAndCommentsImageSize: CGFloat = Platform.is(.iPadOS) ? 30 : 22
    static let reactionsAndCommentsTextFontSize: CGFloat = Platform.is(.iPadOS) ? 20 : 13
    static let viewsLeadingPadding: CGFloat = Platform.is(.iPadOS) ? imageSize + imageAndNameSpacing : .zero
    static let viewsTopPadding: CGFloat = Platform.is(.iPadOS) ? 12 : 4
    static let minReadFontSize: CGFloat = Platform.is(.iPadOS) ? 20 : 11
    static let saveButtonFontSize: CGFloat = Platform.is(.iPadOS) ? 22 : 12
    static let minReadAndSaveButtonSpacing: CGFloat = Platform.is(.iPadOS) ? 15 : 10
    static let saveButtonContentPadding: CGFloat = Platform.is(.iPadOS) ? 10 : 8
}

extension TagListView.Layout {
    static let tagFontSize: CGFloat = Platform.is(.iPadOS) ? 20 : 12
}
