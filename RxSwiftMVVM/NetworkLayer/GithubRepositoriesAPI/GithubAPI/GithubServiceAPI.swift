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
        return baseLoad(url: url).flatMap { result -> Observable<[RepositoryDTO]> in
            return Observable<[RepositoryDTO]>.create { observer in
                switch result {
                case .success(let rawData):
                    completion()
                    if let data: [RepositoryDTO] = self.parse(data: rawData) {
                        observer.onNext(data)
                    }
                case .failure(_):
                    completion()
                }
                return Disposables.create()
            }
        }
    }
    
    func loadImage(imageUrl: String) -> Observable<UIImage> {
        guard let url = URL(string: imageUrl) else { return .just(UIImage())}
        return Observable.create { observer in
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in
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
                if let data = data,
                   let image = UIImage(data: data) {
                    observer.onNext(image)
                }
            }.resume()
            return Disposables.create()
        }
    }
    
    private func baseLoad(url: URL, completion: @escaping ((Result<Data, Error>) -> Void)) {
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
                completion(.failure(error))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkError()))
                print("dont found response")
                return
            }
            if (200...300).contains(response.statusCode),
               let data = data
            {
                completion(.success(data))
            }
        }.resume()
    }
    
    private func baseLoad(url: URL) -> Observable<Result<Data, Error>> {
        return Observable.create { observer in
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print(error)
                    observer.onNext(.failure(error))
                    return
                }
                guard let response = response as? HTTPURLResponse else {
                    print("dont found response")
                    observer.onNext(.failure(NetworkError()))
                    return
                }
                if (200...300).contains(response.statusCode),
                   let data = data
                {
                    observer.onNext(.success(data))
                }
            }.resume()
            return Disposables.create()
        }
    }
    
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

public class NetworkError: Error {
    
}
