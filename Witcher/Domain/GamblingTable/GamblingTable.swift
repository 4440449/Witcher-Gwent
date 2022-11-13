//
//  GamblingTable.swift
//  Witcher
//
//  Created by Maxim Terpugov on 05.11.2022.
//


struct GamblingTable {
    
    struct Player {
        var score: Int
        var availableCards: [Card]
        var foldInRound: Bool
        var isMoveAvailable: Bool
        var availableMoves: Int
    }
    
    struct AI {
        var score: Int
        var availableCards: [Card]
        var foldInRound: Bool
        var isMoveAvailable: Bool
        var availableMoves: Int
    }
    
    struct Round {
        var aiWonRounds: Int
        var playerWonRounds: Int
        var currentCountOfMovesInRound: Int
        var currentCountOfRounds: Int
    }
    
    struct Game {
        var playerWon: Int
        var aiWon: Int
    }
    
    var player: Player
    var ai: AI
    var round: Round
    var game: Game
}
