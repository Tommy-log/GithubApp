//
//  APIService.swift
//  RxSwiftMVVM
//
//  Created by User on 22.07.2022.
//

import Foundation
import RxSwift

enum Path: String {
    case gitHubRepo = "http://jservice.io/api/random?count=1"
}

final class APIServiceProvider {
    
    public init() {
    }
    
    
    func getRepositories(repoID: String) -> Observable<[RepositoryDTO]> {
        guard !repoID.isEmpty, let url = URL(string: Path.gitHubRepo.rawValue) else { return Observable.just([])}
        return URLSession.shared.rx.json(request: URLRequest(url: url))
            .replay(3)
            .map { data in
                var repositories: [RepositoryDTO] = []
                if  let data = data as? [String : Any] {
                    guard let name = data["name"] as? String,
                          let url = data["html_url"] as? String else { return [] }
                    repositories.append(RepositoryDTO(name: name, url: url))
                    
                }
                return repositories
            }
        
    }
}
