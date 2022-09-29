//
//  StoryDisplay.swift
//  InstagramStories
//
//  Created by Sergey Lukaschuk on 29.09.2022.
//

import SwiftUI

struct StoryDisplay: View {

    var images: [String] = ["image01", "image02", "image03", "image04", "image05",]

    @ObservedObject var storyTimer = StoryTimer(items: 5, interval: 5.0)

    var body: some View {
        GeometryReader{ geometry in
            ZStack(alignment: .top) {
                Image("rectangle02")
                    .resizable()
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
//                    .scaledToFill()
//                    .frame(width: geometry.size.width, height: nil, alignment: .center)

                Button {
                    let _ = print("Button pressed")
                } label: {
                    Text("Button")
                }
                .padding([.leading], 20)


//                Image(self.images[Int(self.storyTimer.progress)])
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: geometry.size.width/2, height: geometry.size.height/2, alignment: .leading)
////                    .resizable()
////                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
////                    .scaledToFill()
////                    .frame(width: geometry.size.width,height: nil,alignment: .center)
////                    .animation(.default, value: storyTimer.progress)

                HStack(alignment: .center, spacing: 4){
                    ForEach(0..<images.count, id:\.self) { index in
                        StoryProgressBar(progress: min( max( (CGFloat(self.storyTimer.progress) - CGFloat(index)), 0.0) , 1.0) )
                            .frame(width:nil, height: 5, alignment:.leading)
                            .animation(.linear, value: index)
                    }
                }
                .padding()

                HStack(alignment:.center,spacing: 0) {
                    Rectangle()
                        .padding([.top], 50)
                        .foregroundColor(.clear)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.storyTimer.advance(by: -1)
                        }
                    
                    Rectangle()
                        .padding([.top], 50)
                        .foregroundColor(.clear)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.storyTimer.advance(by: 1)
                        }

                }
            }
            .onAppear {
                self.storyTimer.start()
            }
        }
    }
}

struct StoryDisplay_Previews: PreviewProvider {
    static var previews: some View {
        StoryDisplay()
    }
}
