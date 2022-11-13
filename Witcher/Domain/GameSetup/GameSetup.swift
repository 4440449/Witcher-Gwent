//
//  GameSetup.swift
//  Witcher
//
//  Created by Maxim Terpugov on 04.11.2022.
//


struct GameSetup {
    
    let player: Player
    var ai: Player
    let totalCountOfMovesInRound: Int
    var totalCountOfRounds: Int
    
    enum AI: String, CaseIterable {
        case low = "Слабый"
        case medium = "Средний"
        case hard = "Тяжелый"
    }
    
    init(player: Player,
         aiSetup: AI,
         totalCountOfMovesInRound: Int,
         totalCountOfRounds: Int) {
        self.player = player
        self.totalCountOfMovesInRound = totalCountOfMovesInRound
        self.totalCountOfRounds = totalCountOfRounds
        
        switch aiSetup {
            // Сложность бота (меняется сила колоды)
        case .low:
            // Low card deck setup
            self.ai = Player(name: "LowBot",
                             cardDeck: lowAiCardDeck)
        case .medium:
            // Medium card deck setup
            self.ai = Player(name: "MediumBot",
                             cardDeck: mediumAiCardDeck)
        case .hard:
            // Hard card deck setup
            self.ai = Player(name: "HardBot",
                             cardDeck: hardAiCardDeck)
        }
    }
    
    private let lowAiCardDeck = [
        Card(id: 1, type: .warrior(.init(damage: 5))),
        Card(id: 2, type: .warrior(.init(damage: 5))),
        Card(id: 3, type: .warrior(.init(damage: 3))),
        Card(id: 4, type: .warrior(.init(damage: 3))),
        Card(id: 5, type: .warrior(.init(damage: 3))),
        Card(id: 6, type: .warrior(.init(damage: 1))),
        Card(id: 7, type: .warrior(.init(damage: 1))),
        Card(id: 8, type: .warrior(.init(damage: 1))),
        Card(id: 9, type: .warrior(.init(damage: 1))),
        Card(id: 10, type: .warrior(.init(damage: 1))),
        Card(id: 11, type: .warrior(.init(damage: 1))),
        Card(id: 12, type: .warrior(.init(damage: 1))),
        Card(id: 13, type: .warrior(.init(damage: 1))),
        Card(id: 14, type: .warrior(.init(damage: 1))),
        Card(id: 15, type: .warrior(.init(damage: 1))),
        Card(id: 16, type: .warrior(.init(damage: 1))),
        Card(id: 17, type: .warrior(.init(damage: 1))),
        Card(id: 18, type: .warrior(.init(damage: 1))),
        Card(id: 19, type: .warrior(.init(damage: 1))),
        Card(id: 20, type: .warrior(.init(damage: 1))),
    ]

    private let mediumAiCardDeck = [
        Card(id: 1, type: .warrior(.init(damage: 6))),
        Card(id: 2, type: .warrior(.init(damage: 6))),
        Card(id: 3, type: .warrior(.init(damage: 4))),
        Card(id: 4, type: .warrior(.init(damage: 4))),
        Card(id: 5, type: .warrior(.init(damage: 4))),
        Card(id: 6, type: .warrior(.init(damage: 2))),
        Card(id: 7, type: .warrior(.init(damage: 2))),
        Card(id: 8, type: .warrior(.init(damage: 2))),
        Card(id: 9, type: .warrior(.init(damage: 2))),
        Card(id: 10, type: .warrior(.init(damage: 2))),
        Card(id: 11, type: .warrior(.init(damage: 1))),
        Card(id: 12, type: .warrior(.init(damage: 1))),
        Card(id: 13, type: .warrior(.init(damage: 1))),
        Card(id: 14, type: .warrior(.init(damage: 1))),
        Card(id: 15, type: .warrior(.init(damage: 1))),
        Card(id: 16, type: .warrior(.init(damage: 1))),
        Card(id: 17, type: .warrior(.init(damage: 1))),
        Card(id: 18, type: .warrior(.init(damage: 1))),
        Card(id: 19, type: .warrior(.init(damage: 1))),
        Card(id: 20, type: .warrior(.init(damage: 1))),
    ]

    private let hardAiCardDeck = [
        Card(id: 1, type: .warrior(.init(damage: 7))),
        Card(id: 2, type: .warrior(.init(damage: 7))),
        Card(id: 3, type: .warrior(.init(damage: 5))),
        Card(id: 4, type: .warrior(.init(damage: 5))),
        Card(id: 5, type: .warrior(.init(damage: 5))),
        Card(id: 6, type: .warrior(.init(damage: 3))),
        Card(id: 7, type: .warrior(.init(damage: 3))),
        Card(id: 8, type: .warrior(.init(damage: 3))),
        Card(id: 9, type: .warrior(.init(damage: 3))),
        Card(id: 10, type: .warrior(.init(damage: 3))),
        Card(id: 11, type: .warrior(.init(damage: 2))),
        Card(id: 12, type: .warrior(.init(damage: 2))),
        Card(id: 13, type: .warrior(.init(damage: 2))),
        Card(id: 14, type: .warrior(.init(damage: 2))),
        Card(id: 15, type: .warrior(.init(damage: 2))),
        Card(id: 16, type: .warrior(.init(damage: 2))),
        Card(id: 17, type: .warrior(.init(damage: 2))),
        Card(id: 18, type: .warrior(.init(damage: 2))),
        Card(id: 19, type: .warrior(.init(damage: 2))),
        Card(id: 20, type: .warrior(.init(damage: 2))),
    ]
    
}



