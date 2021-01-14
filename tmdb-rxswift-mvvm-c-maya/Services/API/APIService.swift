//
//  APIService.swift
//  tmdb-rxswift-mvvm-c-maya
//
//  Created by Tanvir Hasan Piash on 13/1/21.
//

import Foundation
import RxCocoa
import RxSwift

class APIService {
    
    private lazy var decoder = JSONDecoder()
    
    private var urlSession: URLSession
    
    init(config: URLSessionConfiguration) {
        
        urlSession = URLSession(configuration: URLSessionConfiguration.default)
        
    }
    
    static let shared = APIService(config: .default)
    
    private func configureRequest(for router: APIRouter) -> URLRequest? {
        
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        components.queryItems = router.parameters
        
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = router.method
        request.addValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HttpHeaderField.contentType.rawValue)
        
        return request
        
    }
    
    func request<T: Codable>(for router: APIRouter) -> Observable<T> {
        
        guard let request = configureRequest(for: router) else { return .empty() }
        
        return Observable.create { observer in
            
            let task = self.urlSession.dataTask(with: request) { (data, response, error) in
                
                if let httpResponse = response as? HTTPURLResponse {
                    
                    let statusCode = httpResponse.statusCode
                    
                    do {
                        
                        let _data = data ?? Data()
                        
                        if (200...399).contains(statusCode) {

                            let result = try self.decoder.decode(T.self, from: _data)
                            observer.onNext(result)
                            
                        } else {
                            
                            observer.onError(error!)
                            
                        }
                    } catch {
                        
                        observer.onError(error)
                        print(error)
                        
                    }
                }
                
                observer.onCompleted()
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
            
        }
        
    }
    
}
