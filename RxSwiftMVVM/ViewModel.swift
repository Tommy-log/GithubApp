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

class ViewModel: ViewModelType {
    
    private let disposeBug = DisposeBag()
    private var APIServiceProvider: APIServiceProvider
    let itemsPublish = PublishSubject<[RepositoryDTO]>()
    
    init(api: APIServiceProvider) {
        self.APIServiceProvider = api
        
    }
    struct Input {
        var myButtonTap: Observable<Void>
        var text: Observable<String>
        var tableViewCellSelected: Observable<IndexPath>
    }
    
    struct Output {
        var greeting: Driver<String>
        var selectedItemForIndexPath: Driver<String>
    }
    
    func featchItems() {
        let repositories = [
            RepositoryDTO(name: "repo 1", url: "url ..."),
            RepositoryDTO(name: "repo 2", url: "url ..."),
            RepositoryDTO(name: "repo 3", url: "url ..."),
            RepositoryDTO(name: "repo 4", url: "url ..."),
            RepositoryDTO(name: "repo 5", url: "url ..."),
            RepositoryDTO(name: "repo 6", url: "url ..."),
            RepositoryDTO(name: "repo 7", url: "url ...")
        ]
        itemsPublish.onNext(repositories)
        itemsPublish.onCompleted()
    }
    
    func transform(input: Input) -> Output {
        return Output(greeting: input.myButtonTap.withLatestFrom(input.text).map({ text in
            return "Hello \(text)"
        }).asDriver(onErrorJustReturn: "Error"),
                      selectedItemForIndexPath: input.tableViewCellSelected.map({
            return "indexPath is: \($0)"
        }).asDriver(onErrorJustReturn: "ERROR")
        )
    }
}
