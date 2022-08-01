//
//  AppMainFactory.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 01/08/22.
//

import UIKit

class AppMainFactory {
    
    private let navigationController: UINavigationController = UINavigationController()
    
    func makeMainAppWindowWith(appScene: UIWindowScene) -> UIWindow? {
        let window = UIWindow(windowScene: appScene)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return window
    }
    
    func makeAppFlowController() -> FlowController {
        let viewControllerfactory = ViewControllersFactory()
        
        return FlowController(navigationController: navigationController,
                              factory: viewControllerfactory)
    }
}
