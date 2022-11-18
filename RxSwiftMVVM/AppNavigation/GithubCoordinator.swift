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
    private var navigationController: UINavigationController?
    
    init(appServices: ApiProvider) {
        self.appServices = appServices
    }
    
    func initStory() -> UIViewController {
        let initialRouter = SearchRouter(appService: appServices, segueToDetail: segueDetailScreen)
        let vc = initialRouter.initScene()
        let navigationViewController = UINavigationController(rootViewController: vc)
        self.navigationController = navigationViewController
        return navigationViewController
    }
    
    func segueDetailScreen(injectModel: RepositoryOwnerDTO) {
        let detailRouter = GithubDetailRouter(appService: appServices, injectedModel: injectModel, close: pop)
        let vc = detailRouter.initScene()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func pop() {
        navigationController?.popViewController(animated: true)
    }
}
