//
//  Module.swift
//  DEV
//
//  Created by Hadi on 24/03/2021.
//

import ComposableArchitecture
import SwiftUI

enum Module: String, CaseIterable {
    case home
    case readingList
    case listings
    case podcasts
    case videos
    case tags
    case codeOfConduct
    case faq
    case devShop
    case sponsors
    case about
    case privacyPolicy
    case termsOfUse
    case contact
}

extension Module: Identifiable {
    var id: String { title }

    var title: String {
        switch self {
        case .home:             return "Home"
        case .readingList:      return "Reading List"
        case .listings:         return "Listings"
        case .podcasts:         return "Podcasts"
        case .videos:           return "Videos"
        case .tags:             return "Tags"
        case .codeOfConduct:    return "Code of Conduct"
        case .faq:              return "FAQ"
        case .devShop:          return "DEV Shop"
        case .sponsors:         return "Sponsors"
        case .about:            return "About"
        case .privacyPolicy:    return "Privacy Policy"
        case .termsOfUse:       return "Terms of Use"
        case .contact:          return "Contact"
        }
    }

    var imageName: String { rawValue }

    // swiftlint:disable cyclomatic_complexity
    @ViewBuilder func view(_ store: Store<AppState, AppAction>) -> some View {
        switch self {
        case .home:             HomeView()
        case .readingList:      ReadingListView()
        case .listings:         ListingsView()
        case .podcasts:         PodcastsView()
        case .videos:           VideosView()
        case .tags:             TagsView()
        case .codeOfConduct:    CodeOfConductView()
        case .faq:              FAQView()
        case .devShop:          DEVShopView()
        case .sponsors:         SponsorsView()
        case .about:            AboutView()
        case .privacyPolicy:    PrivacyPolicyView()
        case .termsOfUse:       TermsOfUseView()
        case .contact:          ContactView()
        }
    }
}
