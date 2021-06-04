//
//  Requestable.swift
//  FriendList
//
//  Created by Huy Nguyen on 31/05/2021.
//

import Foundation

public enum HTTPMethodType: String {
    case get     = "GET"
    case post    = "POST"
}

public enum BodyEncoding {
    case json
}

public class Endpoint<R>: ResponseRequestable {
    
    public typealias Response = R
    
    public let path: String
    public let method: HTTPMethodType
    public let headerParamaters: [String: String]
    public let bodyParamatersEncodable: Encodable?
    public let bodyParamaters: [String: Any]
    public let bodyEncoding: BodyEncoding
    public let responseDecoder: ResponseDecoder
    
    public init(path: String,
                method: HTTPMethodType,
                headerParamaters: [String: String] = [:],
                bodyParamatersEncodable: Encodable? = nil,
                bodyParamaters: [String: Any] = [:],
                bodyEncoding: BodyEncoding = .json,
                responseDecoder: ResponseDecoder = JSONResponseDecoder()) {
        self.path = path
        self.method = method
        self.headerParamaters = headerParamaters
        self.bodyParamatersEncodable = bodyParamatersEncodable
        self.bodyParamaters = bodyParamaters
        self.bodyEncoding = bodyEncoding
        self.responseDecoder = responseDecoder
    }
}

public protocol Requestable {
    var path: String { get }
    var method: HTTPMethodType { get }
    var headerParamaters: [String: String] { get }
    var bodyParamatersEncodable: Encodable? { get }
    var bodyParamaters: [String: Any] { get }
    var bodyEncoding: BodyEncoding { get }

    func urlRequest(with networkConfig: NetworkConfigurable) throws -> URLRequest
}

public protocol ResponseRequestable: Requestable {
    associatedtype Response

    var responseDecoder: ResponseDecoder { get }
}

enum RequestGenerationError: Error {
    case components
}

extension Requestable {

    func url(with config: NetworkConfigurable) throws -> URL {

        let baseURL = config.baseURL.absoluteString.last != "/" ? config.baseURL.absoluteString + "/" : config.baseURL.absoluteString

        guard var urlComponents = URLComponents(string: baseURL.appending(path)) else { throw RequestGenerationError.components }
        var urlQueryItems = [URLQueryItem]()
        
        config.queryParameters.forEach {
            urlQueryItems.append(URLQueryItem(name: $0.key, value: $0.value))
        }
        urlComponents.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil
        guard let url = urlComponents.url else { throw RequestGenerationError.components }
        return url
    }

    public func urlRequest(with config: NetworkConfigurable) throws -> URLRequest {
        
        let url = try self.url(with: config)
        var urlRequest = URLRequest(url: url)
        var allHeaders: [String: String] = config.headers
        headerParamaters.forEach { allHeaders.updateValue($1, forKey: $0) }

        let bodyParamaters = try bodyParamatersEncodable?.toDictionary() ?? self.bodyParamaters
        if !bodyParamaters.isEmpty {
            urlRequest.httpBody = encodeBody(bodyParamaters: bodyParamaters, bodyEncoding: bodyEncoding)
        }
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = allHeaders
        return urlRequest
    }

    private func encodeBody(bodyParamaters: [String: Any], bodyEncoding: BodyEncoding) -> Data? {
        switch bodyEncoding {
        case .json:
            return try? JSONSerialization.data(withJSONObject: bodyParamaters)
        }
    }
}

private extension Dictionary {
    var queryString: String {
        return self.map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
            .addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
    }
}

private extension Encodable {
    func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let josnData = try JSONSerialization.jsonObject(with: data)
        return josnData as? [String : Any]
    }
}
