//
//  LobbyViewModel.swift
//  Witcher
//
//  Created by Maxim Terpugov on 04.11.2022.
//

protocol LobbyViewModelProtocol {
    // Output
    var availableAiSetup: [String] { get }
    var totalCountOfRounds: [Int] { get }
    var selectedAiSetupPickerRow: Int { get }
    var selectedTotalCountOfRoundsPickerRow: Int { get }
    
    // Input
    func aiSetupPickerDidSelectRow(_ row: Int)
    func countOfRoundsPickerDidSelectRow(_ row: Int)
    func startGameButtonTapped()
}


final class LobbyViewModel: LobbyViewModelProtocol {
    
    // MARK: - Dependencies
    
    private let router: LobbyRouterProtocol
    private let player: Player
    
    
    // MARK: - Init
    
    init(router: LobbyRouterProtocol,
         player: Player) {
        self.router = router
        self.player = player
    }
    
    
    // MARK: - Interface
    
    let availableAiSetup: [String] = GameSetup.AI.allCases.map { $0.rawValue }
    let totalCountOfRounds = [3, 5]
    private (set) var selectedAiSetupPickerRow = 1
    private (set) var selectedTotalCountOfRoundsPickerRow = 0
    
    
    func aiSetupPickerDidSelectRow(_ row: Int) {
        selectedAiSetupPickerRow = row
    }
    
    func countOfRoundsPickerDidSelectRow(_ row: Int) {
        selectedTotalCountOfRoundsPickerRow = row
    }
    
    func startGameButtonTapped() {
        let gameSetup = GameSetup(
            player: player,
            aiSetup: GameSetup.AI.allCases[selectedAiSetupPickerRow],
            totalCountOfMovesInRound: 4,
            totalCountOfRounds: totalCountOfRounds[selectedTotalCountOfRoundsPickerRow]
        )
        router.startGameButtonTapped(gameSetup)
    }
    
}
