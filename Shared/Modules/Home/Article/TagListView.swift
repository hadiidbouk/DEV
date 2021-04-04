//
//  TagListView.swift
//  DEV
//
//  Created by Hadi on 02/04/2021.
//

import SwiftUI

struct TagStyle: Hashable {
    var backgroundColor: Color = .clear
    var hashColor: Color = .tertiaryText
    var textColor: Color = .secondaryText
}

struct TagItem: Identifiable, Hashable {
    let id = UUID()
    let text: String
    var style = TagStyle()
}

private typealias Layout = TagListView.Layout

extension TagListView {
    enum Layout {
        static let tagTextPadding: CGFloat = 3
        static let tagCornerRadius: CGFloat = 5
    }
}

struct TagListView: View {
    @State private var rect: CGRect = .zero

    let tags: [TagItem]
    var body: some View {
        VStack {
            GeometryReader { geometry in
                generateContent(in: geometry)
            }
        }
        .frame(height: rect.size.height)
        .font(.system(size: Layout.tagFontSize))
    }

    private func generateContent(in geometry: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(tags) { tag in
                TagView(text: tag.text, style: tag.style)
                    .alignmentGuide(.leading) { dimension in
                        if abs(width - dimension.width) > geometry.size.width {
                            width = .zero
                            height -= dimension.height
                        }
                        let result = width
                        width = tag == tags.last ? .zero : width - dimension.width
                        return result
                    }
                    .alignmentGuide(.top) { _ in
                        let result = height
                        if tag == tags.last {
                            height = .zero
                        }
                        return result
                    }
            }
        }
        .background(rectReader($rect))
    }
}

private struct TagView: View {
    let text: String
    let style: TagStyle

    var body: some View {
        HStack(spacing: .zero) {
            Text("#")
                .foregroundColor(style.hashColor)

            Text(text)
                .foregroundColor(style.textColor)
        }
        .padding(Layout.tagTextPadding)
        .background(style.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: Layout.tagCornerRadius))
    }
}

#if DEBUG
struct TagListView_Previews: PreviewProvider {
    static var previews: some View {
        TagListView(tags: [.init(text: "programming")])
    }
}
#endif
