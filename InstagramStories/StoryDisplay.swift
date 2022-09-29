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
        GeometryReader { geometry in

            ZStack {
                Image("rectangle02")
                    .resizable()
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)


                VStack() {
                    HStack(alignment: .center, spacing: 4){
                        ForEach(0..<images.count, id:\.self) { index in
                            StoryProgressBar(progress: min( max( (CGFloat(self.storyTimer.progress) - CGFloat(index)), 0.0) , 1.0) )
                                .frame(width:nil, height: 5, alignment:.leading)
                                .animation(.linear, value: index)
                        }
                    }

                    HStack() {
                        Spacer()
                        Button {
                            // Action
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(Color.white)
                        }
                        .padding(10)
                    }


                    VStack {
                        HStack() {
                            Text("Title")
                            Spacer()
                        }
                        .foregroundColor(.white)
                        .font(.title)

                        HStack() {
                            Text("Description")
                            Spacer()
                        }
                        .padding(.top, 20)
                        .foregroundColor(.white)

                        Spacer()

                        Image("image01")
                            .resizable()
                            .frame(width: geometry.size.width/2, height: geometry.size.height/2)
                            .scaledToFill()
                        Spacer()

                        
                    }


                    Button {
                        // Action
                    } label: {
                        Text("Button pressed 2")
                            .frame(width: geometry.size.width - 50, height: 50)
                            .background(Color.white)
                            .cornerRadius(5)
                    }
                }
                .padding()
            }
            .onAppear {
                self.storyTimer.start()
            }
            .gesture(
                DragGesture()
                    .onEnded { value in
                        if value.translation.width > 0 {
                            self.storyTimer.advance(by: -1)
                        } else {
                            self.storyTimer.advance(by: 1)
                        }
                    }
            )
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onEnded { value in
                        if value.location.x < geometry.size.width / 2 {
                            self.storyTimer.advance(by: -1)
                        } else {
                            self.storyTimer.advance(by: 1)
                        }
                    }
            )
        }
    }
}

struct StoryDisplay_Previews: PreviewProvider {
    static var previews: some View {
        StoryDisplay()
    }
}
