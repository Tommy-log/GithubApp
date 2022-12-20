//
//  SearchViewModel.swift
//  RxSwiftMVVM
//
//  Created by User on 15.08.2022.
//

import RxCocoa
import RxSwift
import Foundation

class SearchViewModel: ViewModelType {
    
    private let disposeBug = DisposeBag()
    private var githubService: GihubService
    var itemsPublish = PublishSubject<[RepositoryDTO]>()
    private let loadStateActivatePublish = PublishSubject<Bool>()
    private let showHintPublish = PublishSubject<Bool>()
    var repositoriesData: Driver<[RepositoryDTO]>?
    private var isInfoHidden = false
    
    init(api: GihubService) {
        self.githubService = api
    }
    
    struct Input {
        var myButtonTap: Observable<Void>
        var infoButtonTap: Observable<Void>
        var text: Observable<String>
        var tableViewCellSelected: Observable<IndexPath>
    }
    
    struct Output {
        var activateLoadStatePublisher: Observable<Bool>
        var showHintPublisher: Observable<Bool>
    }
    
    func transform(input: Input) -> Output {
        self.repositoriesData = input.text.throttle(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest({ text -> Observable<[RepositoryDTO]> in
                let completion = { self.loadStateActivatePublish.onNext(false) }
                if text.isEmpty {
                    self.loadStateActivatePublish.onNext(false)
                    self.showHintPublish.onNext(true)
                    return .just([])
                }
                self.loadStateActivatePublish.onNext(true)
                self.showHintPublish.onNext(false)
               return self.githubService.getRepositories(repoID: text, completion: completion)
            }).asDriver(onErrorJustReturn: [])
        
        return Output(activateLoadStatePublisher: loadStateActivatePublish, showHintPublisher: showHintPublish)
    }
}

