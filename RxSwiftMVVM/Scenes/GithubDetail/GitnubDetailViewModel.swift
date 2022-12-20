//
//  GitnubDetailViewModel.swift
//  RxSwiftMVVM
//
//  Created by User on 28.09.2022.
//

import UIKit
import RxSwift

final class GithubDetailViewModel: ViewModelType {
    
    private let repositoryOwnerModel: RepositoryOwnerDTO
    private var githubService: GihubService
    private let imagePublish = PublishSubject<UIImage>()
    private var image: UIImage?
    
    init(repositoryOwnerModel: RepositoryOwnerDTO, githubService: GihubService) {
        self.repositoryOwnerModel = repositoryOwnerModel
        self.githubService = githubService
    }
    
    struct Input {
        
    }
    
    struct Output {
        let ownerImageObservable: Observable<UIImage>
    }
    
    func transform(input: Input) -> Output {
        return Output(ownerImageObservable: githubService.loadImage(imageUrl: repositoryOwnerModel.avatarUrl))
    }
}


