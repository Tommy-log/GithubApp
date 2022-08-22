//
//  GithubCoordinator.swift
//  RxSwiftMVVM
//
//  Created by User on 22.08.2022.
//

import Foundation
import UIKit

public final class GithubCoordinator: CoordinatorProtocol {
    
    private let appServices: ApiProvider
    
    init(appServices: ApiProvider) {
        self.appServices = appServices
    }
    
    func initStory() -> UIViewController {
        let initialRouter = SearchRouter(appService: appServices)
        let vc = initialRouter.initScene()
        let navigationViewController = UINavigationController(rootViewController: vc)
        return navigationViewController
    }
}
