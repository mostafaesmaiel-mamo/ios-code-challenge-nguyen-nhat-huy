//
//  RepositoryTask.swift
//  FriendList
//
//  Created by Huy Nguyen on 08/06/2021.
//

import Foundation
import Networking

class RepositoryTask: Cancellable {
    var networkTask: NetworkCancellable?
    var isCancelled: Bool = false
    
    func cancel() {
        networkTask?.cancel()
        isCancelled = true
    }
}
