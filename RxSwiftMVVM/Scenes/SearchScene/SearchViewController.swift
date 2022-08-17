//
//  SearchViewController.swift
//  RxSwiftMVVM
//
//  Created by User on 15.08.2022.
//

import UIKit
import RxSwift
import RxCocoa


class SearchViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rx.setDelegate(self).disposed(by: disposedBag)
       return tableView
    }()
    private lazy var myButton: UIButton = {
       let button = UIButton()
        button.setTitle("Done", for: .normal)
        return button
    }()
    
    private lazy var informLabel: UILabel = {
        let label = UILabel()
        label.text = "please fill user name"
        return label
    }()
    
    private lazy var myTextField: UITextField = {
       let textField = UITextField()
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .secondarySystemFill
        textField.textColor = .secondaryLabel
        return textField
    }()
    
    private lazy var infoButton = UIBarButtonItem(image: UIImage(named: "infoIcon")?.withTintColor(.black), style: .plain, target: nil, action: nil)
    
    private lazy var loaderView: LoaderView = {
        let imageView = LoaderView()
        return imageView
    }()
    
    private var tableViewTopConstraint: NSLayoutConstraint?
    
    private var viewModel: SearchViewModel?
    private let disposedBag = DisposeBag()
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bind()
        bindTableView()
        setupNavigationView()
    }
    
    func setupNavigationView() {
        self.title = "REPOS SEARCHING"
        self.navigationItem.rightBarButtonItem = infoButton
    }
    
    func activateLoadState(_ isActive: Bool) {
        guard let tableViewTopConstraint = tableViewTopConstraint else { return }
        loaderView.showLoader(isActive)
        self.view.layoutSubviews()
        UIView.animate(withDuration: 0.2) {
            tableViewTopConstraint.constant = isActive ? 40 : 0
            self.view.layoutSubviews()
        }
    }
    private func setupView() {
        [tableView, myButton, myTextField, loaderView, informLabel].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        })
        let topTableViewContraint = tableView.topAnchor.constraint(equalTo: myTextField.bottomAnchor)
        self.tableViewTopConstraint = topTableViewContraint
        NSLayoutConstraint.activate([
            informLabel.topAnchor.constraint(equalTo: myTextField.bottomAnchor, constant: 8),
            informLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loaderView.topAnchor.constraint(equalTo: myTextField.bottomAnchor),
            loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderView.widthAnchor.constraint(equalToConstant: 40),
            loaderView.heightAnchor.constraint(equalToConstant: 40),
            
            myTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            myTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            myTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            myTextField.heightAnchor.constraint(equalToConstant: 48),
            
            myButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            myButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            myButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            myButton.heightAnchor.constraint(equalToConstant: 48),
            
            topTableViewContraint,
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: myButton.topAnchor)
        ])
    }
    private func bind() {
        let input = SearchViewModel.Input(
            myButtonTap: myButton.rx.tap.asObservable(),
            infoButtonTap: infoButton.rx.tap.asObservable(),
            text: myTextField.rx.text.orEmpty.asObservable(),
            tableViewCellSelected: tableView.rx.itemSelected.asObservable()
        )
        let output = viewModel!.transform(input: input)
        output.activateLoadStatePublisher.debounce(.seconds(0), scheduler: MainScheduler.instance).subscribe { [unowned self] isActive in
            guard let isActive = isActive.element else { return }
            self.activateLoadState(isActive)
        }.disposed(by: disposedBag)
        output.showHintPublisher.debounce(.seconds(0), scheduler: MainScheduler.instance).subscribe { [unowned self] isShow in
            guard let isShow = isShow.element else { return }
            self.informLabel.isHidden = !isShow
        }.disposed(by: disposedBag)
    }
    
    private func bindTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "basicCell")
        guard let viewModel = viewModel else {
            return
        }
        
        tableView.rx.itemSelected.subscribe { [unowned self] in
            guard let indexPath = $0.element else { return }
            self.tableView.deselectRow(at: indexPath, animated: true)
        }.disposed(by: disposedBag)
        
        guard let data = viewModel.repositoriesData else { return }
        data.asObservable().bind(to: tableView.rx.items(cellIdentifier: "basicCell", cellType: UITableViewCell.self)) { identifire, repository, cell in
            cell.textLabel?.text = repository.name
        }.disposed(by: disposedBag)
    }
}

extension SearchViewController: UITableViewDelegate {
    
}


