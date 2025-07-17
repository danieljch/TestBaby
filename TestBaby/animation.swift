//
//  animation.swift
//  TestBaby
//
//  Created by Daniel Jesus Callisaya Hidalgo on 8/5/24.
//
import SwiftUI

struct AnimatedSymbolView: View {
    let symbolName: String
    let color: Color
    let onAnimationComplete: () -> Void
    @Binding var remainingTime: Int
    @State private var startTime: Date?
    @State private var isCompleted = false
    private let totalDuration: TimeInterval = 6.5
    private let animationDuration: TimeInterval = 2
    private let steadyDuration: TimeInterval = 2
    private let jumpDuration: TimeInterval = 0.5

    var body: some View {
        TimelineView(.animation) { context in
            if isCompleted {
                staticView
            } else {
                let time = startTime.map { context.date.timeIntervalSince($0) } ?? 0
                let scale = computeScale(for: time)
                let yOffset = computeYOffset(for: time)
                animatedView(scale: scale, yOffset: yOffset)
            }
        }
        .onAppear {
            startTime = Date()
            scheduleRemainingUpdates()
        }
    }

    private var staticView: some View {
        VStack {
            Image(systemName: symbolName)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .scaleEffect(0.2)
                .offset(y: 0)
                .foregroundColor(color)
            Text("Tiempo restante: \(remainingTime)")
                .font(.headline)
                .padding(.top, 10)
        }
    }

    private func animatedView(scale: CGFloat, yOffset: CGFloat) -> some View {
        VStack {
            Image(systemName: symbolName)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .scaleEffect(scale)
                .offset(y: yOffset)
                .foregroundColor(color)
            Text("Tiempo restante: \(remainingTime)")
                .font(.headline)
                .padding(.top, 10)
        }
    }

    private func scheduleRemainingUpdates() {
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            remainingTime = 4
            DispatchQueue.main.asyncAfter(deadline: .now() + steadyDuration) {
                remainingTime = 3
                DispatchQueue.main.asyncAfter(deadline: .now() + jumpDuration) {
                    remainingTime = 2
                    DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                        remainingTime = 0
                        onAnimationComplete()
                        isCompleted = true
                    }
                }
            }
        }
    }

    private func computeScale(for time: Double) -> CGFloat {
        if time < 2 {
            return 0.2
        } else if time < 4 {
            let progress = (time - 2) / 2
            return 0.2 + easeInOut(t: progress) * 1.8
        } else if time < 4.5 {
            return 2.0
        } else if time < 6.5 {
            let progress = (time - 4.5) / 2
            return 2.0 - easeInOut(t: progress) * 1.8
        } else {
            return 0.2
        }
    }

    private func computeYOffset(for time: Double) -> CGFloat {
        guard time >= 4 && time < 4.75 else { return 0 }
        let s = time - 4
        if s < 0.25 {
            let progress = s / 0.5
            return easeInOut(t: progress) * -30
        } else {
            let startY = easeInOut(t: 0.5) * -30 // -15
            let progress = (s - 0.25) / 0.5
            return startY + easeInOut(t: progress) * (0 - startY)
        }
    }

    private func easeInOut(t: Double) -> Double {
        var t = max(0, min(1, t))
        t *= 2
        if t < 1 {
            return 0.5 * t * t * t
        } else {
            t -= 2
            return 0.5 * (t * t * t + 2)
        }
    }
}