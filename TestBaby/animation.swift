import SwiftUI
import Combine

enum SymbolAnimationType {
    case smallToLarge
    case steady
    case largeToSmall
    case jump
    
    var animation: SymbolAnimation {
        switch self {
        case .smallToLarge: return SymbolAnimation(scale: 2, duration: 1.5, yOffset: 0)
        case .steady: return SymbolAnimation(scale: 2, duration: 2, yOffset: 0)
        case .largeToSmall: return SymbolAnimation(scale: 0.2, duration: 1.5, yOffset: 0)
        case .jump: return SymbolAnimation(scale: 2, duration: 1, yOffset: -100)
        }
    }
}

struct SymbolAnimation: Equatable {
    let scale: CGFloat
    let duration: TimeInterval
    let yOffset: CGFloat
}

struct AnimatedSymbolView: View {
    let symbolName: String
    let animationType: SymbolAnimationType
    let onAnimationComplete: () -> Void
    @Binding var remainingTime: Int
    @State private var scale: CGFloat = 0.2
    @State private var yOffset: CGFloat = 0
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var elapsedTime: TimeInterval = 0

    private var animation: SymbolAnimation {
        animationType.animation
    }

    var body: some View {
        VStack {
            Image(systemName: symbolName)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .scaleEffect(scale)
                .offset(y: yOffset)
                .animation(.easeInOut(duration: animation.duration), value: scale)
                .animation(.easeInOut(duration: animation.duration), value: yOffset)

            Text("Tiempo restante: \(remainingTime)")
                .font(.headline)
                .padding(.top, 10)
        }
        .onAppear {
            startAnimation()
        }
        .onReceive(timer) { _ in
            elapsedTime += 0.1
            if elapsedTime >= animation.duration {
                onAnimationComplete()
                elapsedTime = 0
            }
        }
    }

    private func startAnimation() {
        withAnimation(.easeInOut(duration: animation.duration)) {
            scale = animation.scale
            yOffset = animation.yOffset
        }
    }
}