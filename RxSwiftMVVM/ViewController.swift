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

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var myTextField: UITextField!
    private var viewModel: ViewModule?
    private let disposedBag = DisposeBag()
    @IBOutlet weak var secondTextField: UITextField!
    private let subject = BehaviorRelay(value: "")
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = ViewModule(viewController: self, api: APIServiceProvider())
        bind()
        print("start")
    }
    private func bind() {
        viewModel?.data.drive { repositories in
            print(repositories)
        }
        secondTextField.rx.text.orEmpty.bind(to: subject).disposed(by: disposedBag)
        let input = ViewModule.Input(
            myButtonTap: myButton.rx.tap.asSignal(),
            text: myTextField.rx.text.asDriver(),
            secondText: secondTextField.rx.text.asDriver())
        let output = viewModel!.transform(input: input)
        
        secondTextField.rx.text.orEmpty.bind(to: output.searchSecondText).disposed(by: disposedBag)

        output.text.drive { text in
            self.myLabel.text = text
        }.disposed(by: disposedBag)
    }
}

