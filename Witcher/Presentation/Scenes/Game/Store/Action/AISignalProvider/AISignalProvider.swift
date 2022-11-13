//
//  AISignalProvider.swift
//  Witcher
//
//  Created by Maxim Terpugov on 03.11.2022.
//

import Foundation
import MommysEye


final class AISignalProvider {
    
    // MARK: - Dependencies
    
    private weak var actionPool: AIActionsHandler?
    private let store: StoreOutput
    
    
    // MARK: - Init
    
    init(store: StoreOutput) {
        self.store = store
        setupObservers()
    }
    
    func setupDependencies(actionPool: AIActionsHandler) {
        self.actionPool = actionPool
    }
    
    
    // MARK: - interface
    // Private
    
    private var isMoveAvailable = false {
        didSet {
            if isMoveAvailable {
                self.move(self.store.state.value.gamblingTable.ai.availableCards)
            }
        }
    }
    
    private func setupObservers() {
        store.state.subscribe(
            observer: self,
            callback: { [weak self] state in
                self?.isMoveAvailable = state.gamblingTable.ai.isMoveAvailable
            })
    }
    
    private func move(_ availableCardDeck: [Card]) {
        guard !availableCardDeck.isEmpty else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            let randomNumber = Int.random(in: 1...20)
            if (1...15).contains(randomNumber) {
                let tappedIndex = [Int](availableCardDeck.indices).randomElement()!
                self.actionPool?.dispatch(signal: .aiMove(params: tappedIndex))
            } else {
                self.actionPool?.dispatch(signal: .aiFold)
            }
        }
    }
    
}
