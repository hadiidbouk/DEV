//
//  RoundedImageView.swift
//  DEV
//
//  Created by Hadi on 01/04/2021.
//

import SwiftUI

private enum Layout {
    static let borderWidth: CGFloat = 3
}

struct RoundedImageView: View {
    let image: Image

    var body: some View {
        image
            .resizable()
            .overlay(
                Circle()
                    .stroke(Color.border, lineWidth: Layout.borderWidth)
            )
            .clipShape(Circle())
    }
}

#if DEBUG
struct RoundedImageView_Previews: PreviewProvider {
    static var previews: some View {
        RoundedImageView(image: Image("user"))
            .frame(width: 130, height: 130)
    }
}
#endif
