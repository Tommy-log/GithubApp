//
//  SearchConfigurator.swift
//  RxSwiftMVVM
//
//  Created by User on 15.08.2022.
//

import UIKit

protocol SearchRouterProtocol: BaseRouter {
    func initScene() -> UIViewController
    func pushSecond()
}

public final class SearchRouter: SearchRouterProtocol {
    
    let appService: ApiProvider
    init(appService: ApiProvider) {
        self.appService = appService
    }
    public func initScene() -> UIViewController {
        let viewModel = SearchViewModel(api: appService.githubService())
        let vc = SearchViewController(viewModel: viewModel)
        return vc
    }
    
    public func pushSecond() {
    }
}
