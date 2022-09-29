//
//  StoryProgressBar.swift
//  InstagramStories
//
//  Created by Sergey Lukaschuk on 29.09.2022.
//

import SwiftUI

struct StoryProgressBar: View {

    var progress: CGFloat

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.white.opacity(05))
                    .cornerRadius(5)
                Rectangle()
                    .frame(width: geometry.size.width * self.progress,
                           height: nil,
                           alignment: .leading)
                    .foregroundColor(.white)
                    .cornerRadius(5)
            }
        }
    }
}


struct LoadingProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        StoryProgressBar(progress: 0.1)
    }
}
