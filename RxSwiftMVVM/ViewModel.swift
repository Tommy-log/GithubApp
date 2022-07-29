//
//  ViewModel.swift
//  RxSwiftMVVM
//
//  Created by User on 28.07.2021.
//

import RxCocoa
import RxSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

class ViewModule: ViewModelType {
    
    weak var viewController: ViewController?
    var searchSecondText = BehaviorSubject(value: "")
    private let disposeBug = DisposeBag()
    private var APIServiceProvider: APIServiceProvider
    var data: Driver<[RepositoryDTO]>
    
    init(viewController: ViewController, api: APIServiceProvider) {
        self.viewController = viewController
        self.APIServiceProvider = api

        data = searchSecondText.throttle(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest({
            api.getRepositories(repoID: $0)
            }).asDriver(onErrorJustReturn: [])
        
            data.drive(onNext: { repositroies in
                print(repositroies)
            }, onCompleted: {
                print("completed")
            }, onDisposed: {
                print("disposed")
            }).disposed(by: disposeBug)

        searchSecondText.subscribe {
            print($0)
        }.disposed(by: disposeBug)
    }
    struct Input {
        var myButtonTap: Signal<Void>
        var text: Driver<String?>
        var secondText: Driver<String?>
    }
    
    struct Output {
        var text: Driver<String?>
        var searchSecondText: BehaviorSubject<String>
        var tapButton: Signal<Void>
        var data: Driver<[RepositoryDTO]>
    }
    
    func transform(input: Input) -> Output {
        return Output(text: Driver.merge([input.text]).map({ return $0?.replacingOccurrences(of: "suka", with: "XXXX")}),
                      searchSecondText: searchSecondText,
        tapButton: input.myButtonTap.asSignal().do(onNext: {
            print("tap")
        }), data: data)
    }
}
