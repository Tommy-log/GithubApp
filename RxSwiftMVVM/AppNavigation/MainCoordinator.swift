//
//  MainCoordinator.swift
//  RxSwiftMVVM
//
//  Created by User on 22.08.2022.
//

import Foundation
import UIKit

public final class MainCoordinator: CoordinatorProtocol {
    
    let tabBarController: MainTabBarController
    private let appServices: ApiProvider
    
    init(appServices: ApiProvider) {
        self.appServices = appServices
        UITabBar.appearance().tintColor = .black
        UITabBar.appearance().barTintColor = .black
        UITabBar.appearance().unselectedItemTintColor = .white
        self.tabBarController = MainTabBarController(appServices: appServices)
    }
    
    func initStory() -> UIViewController {
        return tabBarController
    }
}
