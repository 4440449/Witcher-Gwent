//
//  State.swift
//  Witcher
//
//  Created by Maxim Terpugov on 02.11.2022.
//


struct State {
    // GameSetup
    // Сетится извне (с экрана лобби), далее на основании этих данных создается состояние стола (игра)
    let gameSetup: GameSetup
    // GamblingTable
    var gamblingTable: GamblingTable
    
    init(gameSetup: GameSetup) {
        self.gameSetup = gameSetup
        self.gamblingTable = GamblingTable(
            player: .init(score: 0,
                          availableCards: [], // раздача карт после захода в игру (при событии viewDidLoad)
                          foldInRound: false,
                          isMoveAvailable: true,
                          availableMoves: gameSetup.totalCountOfMovesInRound / 2),
            ai: .init(score: 0,
                      availableCards: [],
                      foldInRound: false,
                      isMoveAvailable: false,
                      availableMoves: gameSetup.totalCountOfMovesInRound / 2),
            round: .init(aiWonRounds: 0,
                         playerWonRounds: 0,
                         currentCountOfMovesInRound: 0,
                         currentCountOfRounds: 1),
            game: .init(playerWon: 0,
                        aiWon: 0))
    }
    
}


