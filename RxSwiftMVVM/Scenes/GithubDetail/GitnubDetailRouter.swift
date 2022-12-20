//
//  GitnubDetailRouter.swift
//  RxSwiftMVVM
//
//  Created by User on 28.09.2022.
//

import UIKit

protocol GithubDetailRouterProtocol: BaseRouter {
    func initScene() -> UIViewController
}

public final class GithubDetailRouter: GithubDetailRouterProtocol {
    
    let appService: ApiProvider
    let close: (() -> Void)
    let injectedModel: RepositoryOwnerDTO
    
    init(appService: ApiProvider, injectedModel: RepositoryOwnerDTO, close: @escaping (() -> Void)) {
        self.appService = appService
        self.close = close
        self.injectedModel = injectedModel
    }
    
    public func initScene() -> UIViewController {
        let viewModel = GithubDetailViewModel(repositoryOwnerModel: injectedModel, githubService: appService.githubService())
        let vc = GitnubDetailViewController(viewModel: viewModel)
        return vc
    }
    
    public func popVC() {
        close()
    }
}
