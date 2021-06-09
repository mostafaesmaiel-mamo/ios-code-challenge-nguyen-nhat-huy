//
//  NetworkService.swift
//  FriendList
//
//  Created by Huy Nguyen on 31/05/2021.
//

import Foundation

public enum NetworkError: Error {
    case error(statusCode: Int, data: Data?)
    case notConnected
    case cancelled
    case generic(Error)
    case urlGeneration
}

public protocol NetworkCancellable {
    func cancel()
}

extension URLSessionTask: NetworkCancellable { }

public protocol NetworkService {
    
    typealias Completion = (Result<Data?, NetworkError>) -> Void
    
    func request(requestable: Requestable, completion: @escaping Completion) -> NetworkCancellable?
}

public protocol NetworkSessionManager {
    
    typealias Completion = (Data?, URLResponse?, Error?) -> Void
    
    func request(_ request: URLRequest,
                 completion: @escaping Completion) -> NetworkCancellable
}

// MARK:- NetworkServiceDefault Implement Protocols

public final class NetworkServiceDefault: NetworkService {
    
    private let config: NetworkConfigurable
    private let session: NetworkSessionManager
    
    public init(config: NetworkConfigurable,
                session: NetworkSessionManager = NetworkSessionManagerDefault()) {
        self.config = config
        self.session = session
    }
    
    public func request(requestable: Requestable, completion: @escaping Completion) -> NetworkCancellable? {
        do {
            let urlRequest = try requestable.urlRequest(with: config)
            return request(request: urlRequest, completion: completion)
        } catch {
            completion(.failure(.urlGeneration))
            return nil
        }
    }
}

// MARK:- NetworkServiceDefault Private Functions

extension NetworkServiceDefault {
    
    private func request(request: URLRequest, completion: @escaping Completion) -> NetworkCancellable {
        
        let sessionDataTask = session.request(request) { data, response, requestError in
            
            guard let requestError = requestError else {
                completion(.success(data))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(self.resolve(error: requestError)))
                return
            }
            
            completion(.failure(.error(statusCode: response.statusCode, data: data)))
        }
        
        return sessionDataTask
    }
    
    private func resolve(error: Error) -> NetworkError {
        let code = URLError.Code(rawValue: (error as NSError).code)
        switch code {
        case .notConnectedToInternet:
            return .notConnected
        case .cancelled:
            return .cancelled
        default:
            return .generic(error)
        }
    }
}

// MARK:- NetworkSessionManagerDefault

public class NetworkSessionManagerDefault: NetworkSessionManager {
    
    public init() { }
    
    public func request(_ request: URLRequest, completion: @escaping Completion) -> NetworkCancellable {
        let task = URLSession.shared.dataTask(with: request, completionHandler: completion)
        task.resume()
        return task
    }
}
