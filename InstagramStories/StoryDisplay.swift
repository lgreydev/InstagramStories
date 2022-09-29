//
//  StoryDisplay.swift
//  InstagramStories
//
//  Created by Sergey Lukaschuk on 29.09.2022.
//

import SwiftUI

struct StoryDisplay: View {

    let images: [String] = ["image01", "image02", "image03", "image04", "image05"]

    let descriptions: [String] = [
        "description_1",
        "description_2",
        "description_3",
        "description_4",
        "description_5",
    ]

    @ObservedObject var storyTimer = StoryTimer(items: 5, interval: 5.0)

    var body: some View {

            ZStack {
                backgroundImage()

                VStack() {
                    progressBar()

                    closeButton()

                    titleText()

                    descriptionLabel()

                    Spacer()

                    animationLottie()

                    Spacer()

                    continueButton()
                }
                .padding()
            }
            .modifier(StartTimer(time: storyTimer))
//            .modifier(TapGesture(time: storyTimer))
            .modifier(SwipeGesture(time: storyTimer))
    }
}

private extension StoryDisplay {
    func backgroundImage() -> some View {
        Image("rectangle02")
            .resizable()
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }

    func progressBar() -> some View {
        HStack(alignment: .center, spacing: 4) {
            ForEach(0..<images.count, id:\.self) { index in
                StoryProgressBar(progress: min( max( (CGFloat(self.storyTimer.progress) - CGFloat(index)), 0.0) , 1.0) )
                    .frame(width:nil, height: 5, alignment:.leading)
                    .animation(.linear, value: index)
            }
        }
    }

    func closeButton() -> some View {
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
    }

    func titleText() -> some View {
        HStack() {
            Text("maib biometric")
            Spacer()
        }
        .foregroundColor(.white)
        .font(.title)
    }

    func descriptionLabel() -> some View {
        HStack() {
            let index = Int(storyTimer.progress)
            Text(descriptions[index])
            Spacer()
        }
        .padding(.top, 10)
        .foregroundColor(.white)
    }

    func animationLottie() -> some View {
        Image("image01")
            .resizable()
            .frame(width: UIScreen.main.bounds.size.width*0.7,
                   height: UIScreen.main.bounds.size.width*0.7)
    }

    func continueButton() -> some View {
        Button {
            // Action
        } label: {
            Text("Button pressed 2")
                .frame(width: UIScreen.main.bounds.size.width - 50, height: 50)
                .background(Color.white)
                .cornerRadius(5)
        }
    }
}


// MARK: Modifier
struct StartTimer: ViewModifier {
    let time: StoryTimer
    func body(content: Content) -> some View {
        content
            .onAppear {
                time.start()
            }
    }
}


struct TapGesture: ViewModifier {
    let time: StoryTimer
    func body(content: Content) -> some View {
        content
            .gesture(
                DragGesture()
                    .onEnded { value in


                        if value.translation.width > 0 {
                            self.time.advance(by: -1)
                        } else {
                            self.time.advance(by: 1)
                        }
                    }
            )
    }
}

/*
if value.startLocation.x < value.location.x - 24 {
            return .left
          }
          if value.startLocation.x > value.location.x + 24 {
            return .right
          }
          if value.startLocation.y < value.location.y - 24 {
            return .down
          }
          if value.startLocation.y > value.location.y + 24 {
            return .up
          }
*/



struct SwipeGesture: ViewModifier {
    let time: StoryTimer
    func body(content: Content) -> some View {
        content
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onEnded { value in
//
//                        if (value.startLocation.x == value.location.x) &&  value.startLocation.x < UIScreen.main.bounds.size.width / 2 {
//                            self.time.advance(by: -1)
//                            let _ = print("tap left")
//                        }
//
//                        if (value.startLocation.x == value.location.x) &&  value.startLocation.x > UIScreen.main.bounds.size.width / 2 {
//                            self.time.advance(by: 1)
//                            let _ = print("tap right")
//                        }

/*
                        if (value.startLocation.x < UIScreen.main.bounds.size.width / 2) &&
                            (value.location.x < UIScreen.main.bounds.size.width / 2) {
                            self.time.advance(by: -1)
                            let _ = print("tap left")
                        }

                        if (value.startLocation.x > UIScreen.main.bounds.size.width / 2) &&
                            (value.location.x > UIScreen.main.bounds.size.width / 2) {
                            self.time.advance(by: 1)
                            let _ = print("tap right")
                        }
*/


                        if value.startLocation.x < value.location.x  {
                            let _ = print("right")
                            self.time.advance(by: 1)
                        }

                        

                        if value.startLocation.x > value.location.x {
                            let _ = print("left")
                            self.time.advance(by: -1)
                        }




                        if value.startLocation.y < value.location.y - 24 {
                            let _ = print("down")
                        }

                        if value.startLocation.y > value.location.y + 24 {
                            let _ = print("up")
                        }

//                        if value.location.x < UIScreen.main.bounds.size.width / 2 {
//                            self.time.advance(by: -1)
//                        } else {
//                            self.time.advance(by: 1)
//                        }


                    }
            )
    }
}






struct StoryDisplay_Previews: PreviewProvider {
    static var previews: some View {
        StoryDisplay()
    }
}
