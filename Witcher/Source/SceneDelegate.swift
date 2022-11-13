//
//  SceneDelegate.swift
//  Witcher
//
//  Created by Maxim Terpugov on 02.11.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let rootVC = LobbySceneConfigurator.configure()
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
    }


}

