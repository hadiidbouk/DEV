//
//  Theme.swift
//  Shared
//
//  Created by Hadi on 23/03/2021.
//

import SwiftUI

enum Theme: String, CaseIterable, Codable {
    case light
    case dark
    case pink
    case `default`

    fileprivate var colors: Colors {
        switch self {
        case .light:    return themesColors.light
        case .dark:     return themesColors.dark
        case .pink:     return themesColors.pink
        case .default:  return isDarkMode ? themesColors.dark : themesColors.light
        }
    }

    private var isDarkMode: Bool {
        #if os(macOS)
            return NSAppearance.current.name == .darkAqua
        #else
            return UITraitCollection.current.userInterfaceStyle == .dark
        #endif
    }
}

extension Color {
    static var background: Color { config.theme.colors.background }
    static var primary: Color { config.theme.colors.primary }
    static var accent: Color { config.theme.colors.accent }
}

// MARK: - private section
private var themesColors: ThemesColors = {
    guard let url = Bundle.main.url(forResource: "Colors", withExtension: "json"),
          let data = try? Data(contentsOf: url) else {
        fatalError("Cannot read colors json file.")
    }
    let decoder = JSONDecoder()
    do {
        let themesColors = try decoder.decode(ThemesColors.self, from: data)
        return themesColors
    } catch let error {
        fatalError(error.localizedDescription)
    }
}()

private struct ThemesColors: Decodable {
    let light: Colors
    let dark: Colors
    let pink: Colors
}

private struct Colors: Decodable {
    private(set) var background: Color = .clear
    private(set) var primary: Color = .clear
    private(set) var accent: Color = .clear

    enum CodingKeys: String, CodingKey {
        case background, primary, accent
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            background = try decodeColor(from: container, with: .background)
            primary = try decodeColor(from: container, with: .primary)
            accent = try decodeColor(from: container, with: .accent)
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }

    private func decodeColor(from container: KeyedDecodingContainer<Colors.CodingKeys>, with key: CodingKeys) throws -> Color {
        let hex = try container.decode(String.self, forKey: key)
        return Color(hex: hex)
    }
}

private extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let alpha, red, green, blue: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (alpha, red, green, blue) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (alpha, red, green, blue) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (alpha, red, green, blue) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (alpha, red, green, blue) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(red) / 255,
            green: Double(green) / 255,
            blue: Double(blue) / 255,
            opacity: Double(alpha) / 255
        )
    }
}
