//
//  NetworkConfigurableMock.swift
//  FriendList
//
//  Created by Huy Nguyen on 11/06/2021.
//

import Foundation
@testable import Networking

class NetworkConfigurableMock: NetworkConfigurable {
    var baseURL: URL = URL(string: "https://mock.test.com")!
    var headers: [String: String] = [:]
    var queryParameters: [String: String] = [:]
}
