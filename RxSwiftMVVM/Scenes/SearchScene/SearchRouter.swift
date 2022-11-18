//
//  SearchConfigurator.swift
//  RxSwiftMVVM
//
//  Created by User on 15.08.2022.
//

import UIKit

protocol SearchRouterProtocol: BaseRouter {
    func initScene() -> UIViewController
    func pushDetail(injectedModel: RepositoryOwnerDTO)
}

public final class SearchRouter: SearchRouterProtocol {
    
    let appService: ApiProvider
    let segueToDetail: ((RepositoryOwnerDTO) -> Void)
    
    init(appService: ApiProvider, segueToDetail: @escaping ((RepositoryOwnerDTO) -> Void)) {
        self.appService = appService
        self.segueToDetail = segueToDetail
    }
    public func initScene() -> UIViewController {
        let viewModel = SearchViewModel(api: appService.githubService())
        let vc = SearchViewController(viewModel: viewModel)
        vc.setRouter(router: self)
        return vc
    }
    
    public func pushDetail(injectedModel: RepositoryOwnerDTO) {
        segueToDetail(injectedModel)
    }
}
