//
//  LobbyRouter.swift
//  Witcher
//
//  Created by Maxim Terpugov on 05.11.2022.
//

import UIKit

protocol LobbyRouterProtocol {
    func startGameButtonTapped(_ gameSetup: GameSetup)
}


final class LobbyRouter: LobbyRouterProtocol {
    
    // MARK: - Dependencies
    
    private unowned var navigationContainer: UINavigationController
    
    
    // MARK: - Init
    
    init(navigationContainer: UINavigationController) {
        self.navigationContainer = navigationContainer
    }
    
    
    // MARK: - Interface

    func startGameButtonTapped(_ gameSetup: GameSetup) {
        startGame(with: gameSetup)
    }
    
    // Private
    private func startGame(with gameSetup: GameSetup) {
        let game = GamblingTableSceneConfigurator.configure(gameSetup)
        navigationContainer.pushViewController(game, animated: true)
        navigationContainer.viewControllers = [game]
    }
}
