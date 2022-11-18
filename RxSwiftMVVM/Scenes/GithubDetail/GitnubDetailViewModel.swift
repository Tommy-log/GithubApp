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
    
    init(repositoryOwnerModel: RepositoryOwnerDTO) {
        self.repositoryOwnerModel = repositoryOwnerModel
        print(repositoryOwnerModel)
    }
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
}


