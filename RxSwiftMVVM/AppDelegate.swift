//
//  AppDelegate.swift
//  RxSwiftMVVM
//
//  Created by User on 28.07.2021.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

      func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
          window = UIWindow(frame: UIScreen.main.bounds)
          let applicationServices = ApiProvider()
          let mainCoordinator: CoordinatorProtocol = MainCoordinator(appServices: applicationServices)
          window?.rootViewController = mainCoordinator.initStory()
          window?.makeKeyAndVisible()
          return true
      }
}

