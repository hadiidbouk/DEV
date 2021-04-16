//
//  RemoteImageView.swift
//  DEV
//
//  Created by Hadi on 08/04/2021.
//

import Kingfisher
import SwiftUI

struct RemoteImageView: View {
    let imageUrl: String
    var cacheId: String = UUID().uuidString
    var placeholder: AnyView = Color.background.anyView

    var body: some View {
        VStack {
            KFImage(URL(string: imageUrl))
                .placeholder { placeholder }
                .cacheMemoryOnly()
                .fromMemoryCacheOrRefresh()
                .resizable()
                .scaledToFill()
        }
    }
}

#if DEBUG
struct MagepieImageView_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImageView(imageUrl: "https://source.unsplash.com/random")
    }
}
#endif
