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
                            let _ = print("Button pressed 1")
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(Color.white)
                        }
                        .padding(10)
                    }

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

                    Button {
                        let _ = print("Button pressed 2")
                    } label: {
                        Text("Button pressed 2")
                            .frame(width: geometry.size.width - 50, height: 50)
                            .background(Color.white)
                            .cornerRadius(5)
                    }






                }
                .padding()

            }


//            ZStack() {
//                Rectangle()
//                    .foregroundColor(.clear)
//                    .contentShape(Rectangle())
//                    .frame(width: geometry.size.width/2, height: geometry.size.height/2)
//                    .background(Color.red)
//
//
//            }
//
//            ZStack {
//                Rectangle()
//                    .foregroundColor(.clear)
//                    .contentShape(Rectangle())
//                    .frame(width: geometry.size.width/2, height: geometry.size.height/2)
//                    .background(Color.blue)
//            }


//            .background(Color.red)
//            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)







/*
            ZStack(alignment: .top) {

                Image("rectangle02")
                    .resizable()
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                //                    .scaledToFill()
                //                    .frame(width: geometry.size.width, height: nil, alignment: .center)



                HStack(alignment: .center, spacing: 4){
                    ForEach(0..<images.count, id:\.self) { index in
                        StoryProgressBar(progress: min( max( (CGFloat(self.storyTimer.progress) - CGFloat(index)), 0.0) , 1.0) )
                            .frame(width:nil, height: 5, alignment:.leading)
                            .animation(.linear, value: index)
                    }
                }
                .padding()

            ZStack() {
                Button {
                    let _ = print("Button pressed")
                } label: {
                    Text("Button")
                }


            }
            .background(Color.red)
            .padding(.top)


                HStack(alignment:.center,spacing: 0) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.storyTimer.advance(by: -1)
                        }

                    Rectangle()
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
 */
        }
    }
}

struct StoryDisplay_Previews: PreviewProvider {
    static var previews: some View {
        StoryDisplay()
    }
}
