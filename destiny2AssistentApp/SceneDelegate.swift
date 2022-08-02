//
//  SceneDelegate.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 23/07/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var flowController: FlowController?
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let factory = AppMainFactory()
        window = factory.makeMainAppWindowWith(appScene: windowScene)
        flowController = factory.makeAppFlowController()
        flowController?.start()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let urlContext = URLContexts.first else {
            return
        }
        flowController?.handle(openURLContext: urlContext)
    }
}
