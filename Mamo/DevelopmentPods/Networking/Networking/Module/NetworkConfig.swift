//
//  NetworkConfig.swift
//  FriendList
//
//  Created by Huy Nguyen on 31/05/2021.
//

import Foundation

public protocol NetworkConfigurable {
    
    var baseURL: URL { get }
    var headers: [String: String] { get }
    var queryParameters: [String: String] { get }
}

public struct APIDataNetworkConfig: NetworkConfigurable {
    
    public let baseURL: URL
    public let headers: [String: String]
    public let queryParameters: [String: String]
    
    public init(baseURL: URL,
                headers: [String: String] = [:],
                queryParameters: [String: String] = [:]) {
       self.baseURL = baseURL
       self.headers = headers
       self.queryParameters = queryParameters
   }
}
