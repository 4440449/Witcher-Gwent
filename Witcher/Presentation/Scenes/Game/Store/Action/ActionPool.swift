//
//  Actions.swift
//  Witcher
//
//  Created by Maxim Terpugov on 02.11.2022.
//

// AI Interface
protocol AIActionsHandler: AnyObject {
    func dispatch(signal: AISignal)
}

enum AISignal {
    case aiMove(params: Int)
    case aiFold
}

// Player Interface
protocol PlayerActionsHandler {
    func dispatch(signal: PlayerSignal)
}

enum PlayerSignal {
    case viewDidLoad
    case didSelectCard(params: Int)
    case foldButtonTapped
}


protocol ActionParams { }
// Action with params
enum Action {
    case handOutCards
    case playerMove(_ actionParams: PlayerMove)
    case playerFold
    case aiMove(_ actionParams: AIMove)
    case aiFold
    
    struct PlayerMove: ActionParams {
        let cardIndex: Int
    }
    
    struct AIMove: ActionParams {
        let cardIndex: Int
    }
}



final class ActionPool: AIActionsHandler,
                        PlayerActionsHandler {
    
    // MARK: - Dependencies
    
    private let store: StoreInput
    private let ai: AISignalProvider
    
    
    // MARK: - Init
    
    init(store: Store,
         ai: AISignalProvider) {
        self.store = store
        self.ai = ai
    }
    
    
    // MARK: - Interface
    
    // AIActionsHandler
    func dispatch(signal: AISignal) {
        switch signal {
        case .aiMove(let params):
            let aiMoveAction: Action = .aiMove(.init(cardIndex: params))
            store.dispatch(aiMoveAction)
        case .aiFold:
            let aiFoldAction: Action = .aiFold
            store.dispatch(aiFoldAction)
        }
    }
    
    // PlayerActionsHandler
    func dispatch(signal: PlayerSignal) {
        switch signal {
        case .viewDidLoad:
            let startGameAction: Action = .handOutCards
            store.dispatch(startGameAction)
            
        case .didSelectCard(let params):
            let index = params
            let playerMoveAction: Action = .playerMove(.init(cardIndex: index))
            store.dispatch(playerMoveAction)
            
        case .foldButtonTapped:
            let playerFoldAction: Action = .playerFold
            store.dispatch(playerFoldAction)
        }
    }
    
}
