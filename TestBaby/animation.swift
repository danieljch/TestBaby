import SwiftUI
import Combine

struct SymbolAnimation: Equatable {
    let scale: CGFloat
    let duration: TimeInterval
    let yOffset: CGFloat

    static let smallToLarge = SymbolAnimation(scale: 2, duration: 1.5, yOffset: 0)
    static let steady = SymbolAnimation(scale: 2, duration: 2, yOffset: 0)
    static let largeToSmall = SymbolAnimation(scale: 0.2, duration: 1.5, yOffset: 0)
    static let jump = SymbolAnimation(scale: 2, duration: 1, yOffset: -100)

    static let allAnimations: [SymbolAnimation] = [smallToLarge, steady, jump, largeToSmall]
}

struct AnimatedSymbolView: View {
    let symbolName: String
    let onAnimationComplete: () -> Void
    @Binding var remainingTime: Int
    @State private var currentAnimationIndex = 0
    @State private var scale: CGFloat = 0.2
    @State private var yOffset: CGFloat = 0
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var elapsedTime: TimeInterval = 0

    private var currentAnimation: SymbolAnimation {
        SymbolAnimation.allAnimations[currentAnimationIndex]
    }

    var body: some View {
        VStack {
            Image(systemName: symbolName)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .scaleEffect(scale)
                .offset(y: yOffset)
                .animation(.easeInOut(duration: currentAnimation.duration), value: scale)
                .animation(.easeInOut(duration: currentAnimation.duration), value: yOffset)

            Text("Tiempo restante: \(remainingTime)")
                .font(.headline)
                .padding(.top, 10)
        }
        .onAppear {
            startAnimationCycle()
        }
        .onReceive(timer) { _ in
            elapsedTime += 0.1
            if elapsedTime >= currentAnimation.duration {
                elapsedTime = 0
                advanceState()
            }
        }
    }

    private func startAnimationCycle() {
        currentAnimationIndex = 0
        advanceState()
    }

    private func advanceState() {
        withAnimation(.easeInOut(duration: currentAnimation.duration)) {
            scale = currentAnimation.scale
            yOffset = currentAnimation.yOffset
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + currentAnimation.duration) {
            currentAnimationIndex = (currentAnimationIndex + 1) % SymbolAnimation.allAnimations.count
            if currentAnimationIndex == 0 {
                onAnimationComplete()
                startAnimationCycle()
            } else {
                advanceState()
            }
        }
    }
}