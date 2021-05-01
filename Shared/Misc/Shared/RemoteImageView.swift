//
//  RemoteImageView.swift
//  DEV
//
//  Created by Hadi on 08/04/2021.
//

import SwiftUI
import URLImage

struct RemoteImageView: View {
    let imageUrl: String
    var cacheId: String = UUID().uuidString
    var placeholder: () -> AnyView = { Color.background.anyView }
    var contentMode: SwiftUI.ContentMode = .fit

    var body: some View {
        guard let url = URL(string: imageUrl) else { return placeholder().anyView }
        let inProgress: (Float?) -> AnyView = { _ in placeholder() }
        let failure: (Error, () -> Void) -> AnyView = { _, _ in placeholder() }

        return URLImage(url: url,
                        empty: placeholder,
                        inProgress: inProgress,
                        failure: failure) { image in
            image
                .resizable()
                .aspectRatio(contentMode: contentMode)
        }
        .anyView
    }
}

#if DEBUG
struct MagepieImageView_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImageView(imageUrl: "https://source.unsplash.com/random")
    }
}
#endif
