//
//  StoryTimer.swift
//  InstagramStories
//
//  Created by Sergey Lukaschuk on 29.09.2022.
//

import Foundation
import Combine

class StoryTimer: ObservableObject {
    @Published var progress: Double
    private var interval: TimeInterval
    private var max: Int
    private let publisher: Timer.TimerPublisher
    private var cancellable: Cancellable?

    init(items: Int, interval: TimeInterval) {
        self.max = items
        self.progress = 0
        self.interval = interval
        self.publisher = Timer.publish(every: 0.1, on: .main, in: .default)
    }
}

extension StoryTimer {
    func start() {
        self.cancellable = self.publisher.autoconnect().sink { _ in
            var newProgress = self.progress + (0.1 / self.interval)
            if Int(newProgress) >= self.max { newProgress = 0 }
            self.progress = newProgress
        }
    }

    func advance(by number: Int) {
        let newProgress = Swift.max((Int(self.progress) + number) % self.max , 0)
        self.progress = Double(newProgress)
    }
}
