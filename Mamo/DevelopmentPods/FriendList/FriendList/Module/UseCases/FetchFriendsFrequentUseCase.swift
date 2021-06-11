//
//  FetchFriendsFrequentUseCase.swift
//  FriendList
//
//  Created by Huy Nguyen on 07/06/2021.
//

import Foundation
import Networking

protocol FetchFriendsFrequentUseCase {
    func execute(completion: @escaping (Result<FriendList, Error>) -> Void) -> Cancellable?
}

final class DefaultFetchFriendsFrequentUseCase: FetchFriendsFrequentUseCase {
    
    private let friendListRepository: FriendListRepository
    
    init(friendListRepository: FriendListRepository) {
        self.friendListRepository = friendListRepository
    }
    
    func execute(completion: @escaping (Result<FriendList, Error>) -> Void) -> Cancellable? {
        
        return friendListRepository.fetchFriendFrequentList { result in
            completion(result)
        }
    }
}
