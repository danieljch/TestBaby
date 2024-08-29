struct SymbolsView: View {
    @State private var oo = SymbolsOO()
    @State private var remainingTime = 6
    @State private var currentAnimationType: SymbolAnimationType = .smallToLarge

    var body: some View {
        VStack {
            if let symbol = oo.currentSymbol {
                AnimatedSymbolView(
                    symbolName: symbol.name,
                    animationType: currentAnimationType,
                    onAnimationComplete: {
                        oo.nextSymbol()
                        remainingTime = 6
                        currentAnimationType = getNextAnimationType()
                    },
                    remainingTime: $remainingTime
                )
                .id(symbol.id)
            }
        }
        .font(.largeTitle)
        .onAppear {
            remainingTime = 6
        }
    }
    
    private func getNextAnimationType() -> SymbolAnimationType {
        let types: [SymbolAnimationType] = [.smallToLarge, .steady, .largeToSmall, .jump]
        let currentIndex = types.firstIndex(of: currentAnimationType) ?? 0
        return types[(currentIndex + 1) % types.count]
    }
}