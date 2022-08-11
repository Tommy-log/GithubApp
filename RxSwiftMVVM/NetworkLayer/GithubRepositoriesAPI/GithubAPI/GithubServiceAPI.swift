//
//  GitHubService.swift
//  RxSwiftMVVM
//
//  Created by User on 06.08.2022.
//
import Foundation
import RxSwift

final class GithubServiceAPI: GihubService {
    
    public init() {
    }
    
    func getRepositories(repoID: String, completion: @escaping (() -> Void)) -> Observable<[RepositoryDTO]> {
        guard !repoID.isEmpty, let url = URL(string: Path.gitHubRepo.rawValue + repoID + Path.gitHubRepoPostfix.rawValue) else { return .just([])}
        return Observable.create { observer in
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in
                completion()
                if let error = error {
                    print(error)
                }
                if let response = response as? HTTPURLResponse {
                    guard response.statusCode == 200 || response.statusCode == 201 else {
                        print("service error")
                        print("status code: \(response.statusCode)")
                        return
                    }
                }
                if let data = data, let repositories: [RepositoryDTO] = self.parse(data: data) {
                    observer.onNext(repositories)
                }
            }.resume()
            return Disposables.create()
        }
    }
    
    
//    func getRepositories(repoID: String, completion: @escaping (() -> Void)) -> Observable<[RepositoryDTO]> {
//        guard !repoID.isEmpty, let url = URL(string: Path.gitHubRepo.rawValue + repoID + Path.gitHubRepoPostfix.rawValue) else { return .just([])}
//        return URLSession.shared.rx.data(request: URLRequest(url: url)).map { data in
//            completion()
//            guard let repositories: [RepositoryDTO] = self.parse(data: data) else { return [] }
//            return repositories
//        }
//    }
    private func parse<T: Decodable>(data: Data) -> T? {
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(T.self, from: data)
            return result
        } catch {
            print("Decode Error")
            return nil
        }
    }
}
