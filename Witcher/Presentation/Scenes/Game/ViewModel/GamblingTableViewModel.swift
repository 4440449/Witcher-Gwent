//
//  GamblingTableViewModel.swift
//  Witcher
//
//  Created by Maxim Terpugov on 02.11.2022.
//

import MommysEye


protocol GamblingTableViewModelProtocol {
    // Output
    var roundScore: Publisher<(Int, Int)> { get }
    var aiScore: Publisher<Int> { get }
    var aiFoldButtonState: Publisher<Bool> { get }
    var playerScore: Publisher<Int> { get }
    var playerIsMoveAvaiable: Publisher<Bool> { get }
    var playerFoldButtonState: Publisher<Bool> { get }
    var availableCards: Publisher<[Card]> { get }
    var currentRound: Publisher<Int> { get }
    var playerGameScore: Publisher<Int> { get }
    var aiGameScore: Publisher<Int> { get }
    
    // Input
    func viewDidLoad()
    func didSelectCard(at index: Int)
    func foldButtonTapped()
}


final class GamblingTableViewModel: GamblingTableViewModelProtocol {
    
    // MARK: - Dependencies
    
    private let actionPool: ActionPool
    
    
    // MARK: - Init
    
    init(actionPool: ActionPool,
         store: StoreOutput) {
        self.actionPool = actionPool
        self.store = store
        setupObservers()
    }
    
    
    // MARK: - State
    
    // Private
    private let store: StoreOutput
    
    private func setupObservers() {
        store.state.subscribe(observer: self,
                              callback: { [weak self] state in
            self?.updateProps(state.gamblingTable)
        })
    }
    
    
    // MARK: - Interface
    
    // Output
    var roundScore = Publisher(value: (0,0))
    var aiScore = Publisher(value: 0)
    var aiFoldButtonState = Publisher(value: false)
    var playerScore = Publisher(value: 0)
    var playerIsMoveAvaiable = Publisher(value: true)
    var playerFoldButtonState = Publisher(value: false)
    var availableCards = Publisher(value: [Card]())
    var currentRound = Publisher(value: 1)
    var playerGameScore = Publisher(value: 0)
    var aiGameScore = Publisher(value: 0)
    
    private func updateProps(_ tableState: GamblingTable) {
        roundScore.value = (tableState.round.aiWonRounds, tableState.round.playerWonRounds)
        aiScore.value = tableState.ai.score
        aiFoldButtonState.value = !tableState.ai.foldInRound
        playerScore.value = tableState.player.score
        playerIsMoveAvaiable.value = tableState.player.isMoveAvailable
        playerFoldButtonState.value = !tableState.player.foldInRound
        availableCards.value = tableState.player.availableCards
        currentRound.value = tableState.round.currentCountOfRounds
        playerGameScore.value = tableState.game.playerWon
        aiGameScore.value = tableState.game.aiWon
    }
    
    // Input
    func viewDidLoad() {
        actionPool.dispatch(signal: .viewDidLoad)
    }
    
    func didSelectCard(at index: Int) {
        actionPool.dispatch(signal: .didSelectCard(params: index))
    }
    
    func foldButtonTapped() {
        actionPool.dispatch(signal: .foldButtonTapped)
    }
    
}
