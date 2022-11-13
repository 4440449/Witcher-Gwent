//
//  LobbySceneConfigurator.swift
//  Witcher
//
//  Created by Maxim Terpugov on 04.11.2022.
//

import UIKit


final class LobbySceneConfigurator: SceneConfiguratorProtocol {
    
    static func configure() -> UIViewController {
        let navigationContainer = UINavigationController()
        navigationContainer.navigationBar.isHidden = true
        let router = LobbyRouter(navigationContainer: navigationContainer)
        let viewModel = LobbyViewModel(router: router,
                                       player: player)
        let lobbyVC = LobbyViewController(viewModel: viewModel)
        navigationContainer.viewControllers = [lobbyVC]
        return navigationContainer
    }
}

// Пользователь со своей колодой заходит в лобби
fileprivate let playerCardDeck = [
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
fileprivate let player = Player(name: "Петя",
                                cardDeck: playerCardDeck)
