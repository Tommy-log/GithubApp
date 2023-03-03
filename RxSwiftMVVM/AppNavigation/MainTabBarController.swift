//
//  MainTabBarController.swift
//  RxSwiftMVVM
//
//  Created by User on 01.03.2023.
//

import UIKit


final class MainTabBarController: UITabBarController {
    
    lazy var tabBarDrawer = TabBarDrawer(tabBarBounds: tabBar.bounds)
    
    init(appServices: ApiProvider) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = viewControllers
        prepareCoordinators(appService: appServices)
        prepareTabBarItems()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarApperance()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == (self.tabBar.items)?[0]{
            tabBarDrawer.selectedItem = 1
        }
        else if item == (self.tabBar.items)?[1]{
            tabBarDrawer.selectedItem = 2
        }
        else if item == (self.tabBar.items)?[2]{
            tabBarDrawer.selectedItem = 3
        }
    }
    
    private func prepareCoordinators(appService: ApiProvider) {
        let githubCoordinator = GithubCoordinator(appServices: appService)
        let test2ViewController = UIViewController()
        test2ViewController.view.backgroundColor = .green
        let test3ViewController = UIViewController()
        test3ViewController.view.backgroundColor = .red
        var allStories: [UIViewController] = []
        [githubCoordinator].forEach {
            allStories.append($0.initStory())
        }
        allStories.append(test2ViewController)
        allStories.append(test3ViewController)
        viewControllers = allStories
        viewControllers?.forEach({
            $0.view.backgroundColor = .secondarySystemBackground
        })
    }
    
    private func prepareTabBarItems() {
        if let firstItem = tabBar.items?[0] {
            firstItem.title = nil
            firstItem.image = UIImage(named: "githubIcon")?.withTintColor(.darkGray)
            firstItem.selectedImage = UIImage(named: "githubIcon")?.withTintColor(.black)
        }
        
        if let secondItem = tabBar.items?[1] {
            secondItem.title = nil
            secondItem.image = UIImage(systemName: "house.fill")?.withTintColor(.darkGray)
            secondItem.selectedImage = UIImage(systemName: "house.fill")?.withTintColor(.black)
        }
        if let thirdItem = tabBar.items?[2] {
            thirdItem.title = nil
            thirdItem.image = UIImage(systemName: "person.fill")?.withTintColor(.darkGray)
            thirdItem.selectedImage = UIImage(systemName: "person.fill")?.withTintColor(.black)
        }
        tabBar.setNeedsLayout()
    }
    
    private func setTabBarApperance() {
        tabBarDrawer.setLayer(for: tabBar)
    }
}
