//
//  APIDataTransfer.swift
//  FriendList
//
//  Created by Huy Nguyen on 01/06/2021.
//

import Foundation

public enum APIDataTransferError: Error {
    case noResponse
    case parsing(Error)
    case networkFailure(NetworkError)
    case resolvedNetworkFailure(Error)
}

public protocol APIDataTransferService {
    typealias CompletionHandler<T> = (Result<T, APIDataTransferError>) -> Void
    
    @discardableResult
    func request<T: Decodable, E: ResponseRequestable>(with endpoint: E,
                                                       completion: @escaping CompletionHandler<T>) -> NetworkCancellable? where E.Response == T
    @discardableResult
    func request<E: ResponseRequestable>(with endpoint: E,
                                         completion: @escaping CompletionHandler<Void>) -> NetworkCancellable? where E.Response == Void
}

public protocol APIDataTransferErrorResolver {
    func resolve(error: NetworkError) -> Error
}

public protocol ResponseDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

public final class APIDataTransferServiceDefault {
    
    private let networkService: NetworkService
    private let errorResolver: APIDataTransferErrorResolver
    
    public init(with networkService: NetworkService,
                errorResolver: APIDataTransferErrorResolver = APIDataTransferErrorResolverDefault()) {
        self.networkService = networkService
        self.errorResolver = errorResolver
    }
}

extension APIDataTransferServiceDefault: APIDataTransferService {

    public func request<T: Decodable, E: ResponseRequestable>(with endpoint: E,
                                                              completion: @escaping CompletionHandler<T>) -> NetworkCancellable? where E.Response == T {

        return self.networkService.request(requestable: endpoint) { result in
            switch result {
            case .success(let data):
                let result: Result<T, APIDataTransferError> = self.decode(data: data, decoder: endpoint.responseDecoder)
                DispatchQueue.main.async { return completion(result) }
            case .failure(let error):
                let error = self.resolve(networkError: error)
                DispatchQueue.main.async { return completion(.failure(error)) }
            }
        }
    }

    public func request<E>(with endpoint: E, completion: @escaping CompletionHandler<Void>) -> NetworkCancellable? where E : ResponseRequestable, E.Response == Void {
        return self.networkService.request(requestable: endpoint) { result in
            switch result {
            case .success:
                DispatchQueue.main.async { return completion(.success(())) }
            case .failure(let error):
                let error = self.resolve(networkError: error)
                DispatchQueue.main.async { return completion(.failure(error)) }
            }
        }
    }

    // MARK: - Private
    private func decode<T: Decodable>(data: Data?, decoder: ResponseDecoder) -> Result<T, APIDataTransferError> {
        do {
            guard let data = data else { return .failure(.noResponse) }
            let result: T = try decoder.decode(data)
            return .success(result)
        } catch {
            return .failure(.parsing(error))
        }
    }

    private func resolve(networkError error: NetworkError) -> APIDataTransferError {
        let resolvedError = self.errorResolver.resolve(error: error)
        return resolvedError is NetworkError ? .networkFailure(error) : .resolvedNetworkFailure(resolvedError)
    }
}

public class APIDataTransferErrorResolverDefault: APIDataTransferErrorResolver {
    public init() { }
    public func resolve(error: NetworkError) -> Error {
        return error
    }
}

public class JSONResponseDecoder: ResponseDecoder {
    private let jsonDecoder = JSONDecoder()
    public init() { }
    public func decode<T: Decodable>(_ data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}

public class RawDataResponseDecoder: ResponseDecoder {
    public init() { }

    enum CodingKeys: String, CodingKey {
        case `default` = ""
    }
    public func decode<T: Decodable>(_ data: Data) throws -> T {
        if T.self is Data.Type, let data = data as? T {
            return data
        } else {
            let context = DecodingError.Context(codingPath: [CodingKeys.default], debugDescription: "Expected Data type")
            throw Swift.DecodingError.typeMismatch(T.self, context)
        }
    }
}
