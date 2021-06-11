//
//  NetworkSessionManagerMock.swift
//  FriendList
//
//  Created by Huy Nguyen on 11/06/2021.
//

import Foundation
@testable import Networking

struct NetworkSessionManagerMock: NetworkSessionManager {
    let response: HTTPURLResponse?
    let data: Data?
    let error: Error?
    
    func request(_ request: URLRequest, completion: @escaping Completion) -> NetworkCancellable {
        completion(data, response, error)
        return URLSessionDataTask()
    }
}
