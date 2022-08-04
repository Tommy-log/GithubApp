//
//  ViewController.swift
//  RxSwiftMVVM
//
//  Created by User on 28.07.2021.
//

import UIKit
import RxSwift
import RxCocoa


class ViewController: UIViewController {

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
    private lazy var myTextField: UITextField = {
       let textField = UITextField()
        textField.backgroundColor = .secondarySystemFill
        textField.textColor = .secondaryLabel
        return textField
    }()
    private var viewModel: ViewModel?
    private let disposedBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.viewModel = ViewModel(api: APIServiceProvider())
        bind()
        bindTableView()
        print("start")
    }
    private func setupView() {
        [tableView, myButton, myTextField].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        })
            
            NSLayoutConstraint.activate([
                myTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
                myTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                myTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
                myTextField.heightAnchor.constraint(equalToConstant: 48),
                
                myButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
                myButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                myButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                myButton.heightAnchor.constraint(equalToConstant: 48),
                
                tableView.topAnchor.constraint(equalTo: myTextField.bottomAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: myButton.topAnchor)
            ])
    }
    private func bind() {
        let input = ViewModel.Input(
            myButtonTap: myButton.rx.tap.asObservable(), text: myTextField.rx.text.orEmpty.asObservable(),
            tableViewCellSelected: tableView.rx.itemSelected.asObservable()
        )
        let output = viewModel!.transform(input: input)
        guard let titleLabel = myButton.titleLabel else { return }
        output.selectedItemForIndexPath.drive(titleLabel.rx.text).disposed(by: disposedBag)
//        output.selectedItemForIndexPath.drive {
//            self.myTextField.text = $0
//        }
    }
    
    private func bindTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "basicCell")
        guard let viewModel = viewModel else {
            return
        }
        viewModel.itemsPublish.bind(to: tableView.rx.items(cellIdentifier: "basicCell", cellType: UITableViewCell.self)) { identifire, repository, cell  in
            cell.textLabel?.text = repository.name + repository.url
        }.disposed(by: disposedBag)
        
        viewModel.featchItems()
      }
}

extension ViewController: UITableViewDelegate {
    
}

