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

            HStack {
                leftActionRectangle()
                rightActionRectangle()
            }

            VStack {
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
        .modifier(SwipeGesture(time: storyTimer))
    }
}

private extension StoryDisplay {
    func backgroundImage() -> some View {
        Image("rectangle02")
            .resizable()
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }

    func leftActionRectangle() -> some View {
        Rectangle()
            .foregroundColor(.clear)
            .contentShape(Rectangle())
            .onTapGesture {
                storyTimer.advance(by: -1)
            }
    }

    func rightActionRectangle() -> some View {
        Rectangle()
            .foregroundColor(.clear)
            .contentShape(Rectangle())
            .onTapGesture {
                storyTimer.advance(by: 1)
            }
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
            .allowsHitTesting(false)
    }

    func continueButton() -> some View {
        Button {
            if storyTimer.progress == 5.99 {
                print("Action")
            }
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

struct TapsGesture: ViewModifier {
    let time: StoryTimer
    func body(content: Content) -> some View {
        content
            .onTapGesture() {
                time.advance(by: 1)
            }
    }
}

struct SwipeGesture: ViewModifier {
    let time: StoryTimer
    func body(content: Content) -> some View {
        content
            .gesture(
                DragGesture(minimumDistance: 1, coordinateSpace: .local)
                    .onEnded { value in

                        if value.startLocation.x < value.location.x  {
                            let _ = print("right")
                            self.time.advance(by: 1)
                        }

                        if value.startLocation.x > value.location.x {
                            let _ = print("left")
                            self.time.advance(by: -1)
                        }
                    }
            )
    }
}









struct StoryDisplay_Previews: PreviewProvider {
    static var previews: some View {
        StoryDisplay()
    }
}
