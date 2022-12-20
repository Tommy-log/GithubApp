//
//  GitnubDetailViewController.swift
//  RxSwiftMVVM
//
//  Created by User on 28.09.2022.
//

import UIKit
import RxSwift

final class GitnubDetailViewController: UIViewController {
    
    private let viewModel: GithubDetailViewModel
    private let disposeBug = DisposeBag()
    
    init(viewModel: GithubDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.bind()
    }
    
    private func setup() {
        let input = GithubDetailViewModel.Input()
        let output = viewModel.transform(input: input)
        let imageView = UIImageView()
        output.ownerImageObservable.bind(to: imageView.rx.image).disposed(by: disposeBug)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func bind() {
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
