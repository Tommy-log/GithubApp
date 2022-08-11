//
//  GithubService.swift
//  RxSwiftMVVM
//
//  Created by User on 06.08.2022.
//

import Foundation
import RxSwift

protocol GihubService: BaseServiceProtocol {
    func getRepositories(repoID: String, completion: @escaping (() -> Void)) -> Observable<[RepositoryDTO]>
}
