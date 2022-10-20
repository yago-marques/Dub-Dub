//
//  SceneDelegate.swift
//  Dub Dub
//
//  Created by Yago Marques on 17/10/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let safeWindow = UIWindow(windowScene: windowScene)
        safeWindow.frame = UIScreen.main.bounds
        safeWindow.makeKeyAndVisible()
        let mainViewController = CharactersExplorerFactory.make()
        safeWindow.rootViewController = UINavigationController(rootViewController: mainViewController)

        self.window = safeWindow
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

