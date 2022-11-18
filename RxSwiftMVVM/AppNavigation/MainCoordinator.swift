//
//  MainCoordinator.swift
//  RxSwiftMVVM
//
//  Created by User on 22.08.2022.
//

import Foundation
import UIKit

public final class MainCoordinator: CoordinatorProtocol {
    
    public let tabBarController: UITabBarController
    private let appServices: ApiProvider
    
    private lazy var gitHubCoordinator: CoordinatorProtocol = GithubCoordinator(appServices: appServices)
    
    init(appServices: ApiProvider) {
        self.appServices = appServices
        tabBarController = UITabBarController()
        UITabBar.appearance().tintColor = .lightText
        UITabBar.appearance().backgroundColor = .darkGray
        tabBarController.selectedIndex = 0
        prepareCoordinators(appService: appServices)
        prepareTabBarItems()
    }
    
    func initStory() -> UIViewController {
        return tabBarController
    }
    
    private func prepareCoordinators(appService: ApiProvider) {
        let githubCoordinator = GithubCoordinator(appServices: appService)
        var allStories: [UIViewController] = []
        [githubCoordinator].forEach {
            allStories.append($0.initStory())
        }
        tabBarController.viewControllers = allStories
        tabBarController.viewControllers?.forEach({
            $0.view.backgroundColor = .secondarySystemBackground
        })
    }
    
    private func prepareTabBarItems() {
        if let firstItem = tabBarController.tabBar.items?[0] {
            firstItem.title = nil
            firstItem.image = UIImage(named: "githubIcon")?.withTintColor(.darkGray)
            firstItem.selectedImage = UIImage(named: "githubIcon")?.withTintColor(.white)
        }
    }
}
