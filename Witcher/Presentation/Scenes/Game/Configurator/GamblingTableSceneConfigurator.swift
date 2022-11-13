//
//  GamblingTableSceneConfigurator.swift
//  Witcher
//
//  Created by Maxim Terpugov on 03.11.2022.
//

import UIKit


final class GamblingTableSceneConfigurator: SceneConfiguratorProtocol {
    
    static func configure(_ gameSetup: GameSetup) -> UIViewController {
        let state = State(gameSetup: gameSetup)
        let reducer = Reducer()
        let store = Store(state: state,
                          reducer: reducer)
        let ai = AISignalProvider(store: store)
        let actionPool = ActionPool(store: store,
                                    ai: ai)
        ai.setupDependencies(actionPool: actionPool)
        let viewModel = GamblingTableViewModel(actionPool: actionPool,
                                               store: store)
        let gamblingTableVC = GamblingTableViewController(viewModel: viewModel)
        return gamblingTableVC
    }
    
}
