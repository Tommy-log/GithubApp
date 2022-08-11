//
//  ApiProvider.swift
//  RxSwiftMVVM
//
//  Created by User on 06.08.2022.
//

import Foundation

public final class ApiProvider {
    func githubService() -> GihubService {
        return GithubServiceAPI()
    }
}
