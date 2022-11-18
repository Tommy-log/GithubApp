//
//  GitnubDetailViewController.swift
//  RxSwiftMVVM
//
//  Created by User on 28.09.2022.
//

import UIKit

final class GitnubDetailViewController: UIViewController {
    
    private let viewModel: GithubDetailViewModel
    
    init(viewModel: GithubDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
