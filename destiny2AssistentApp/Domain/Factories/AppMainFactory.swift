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
        let service = Service(httpClient: URLSession.shared,
                              decoder: DataDecoder())
        
        let authService = AuthenticationService(service: service,
                                                requestFactory: RequestFactory(constants: AuthenticationConstants()))
        
        let viewControllerfactory = ViewControllersFactory(authService: authService,
                                                           service: service)
        
        return FlowController(navigationController: navigationController,
                              factory: viewControllerfactory,
                              authService: authService)
    }
}
