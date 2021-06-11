//
//  SearchFriendUseCase.swift
//  FriendList
//
//  Created by Huy Nguyen on 10/06/2021.
//

import Foundation
import Networking

protocol SearchFriendUseCase {
    func execute(completion: @escaping (Result<FriendList, Error>) -> Void) -> Cancellable?
}

final class DefaultSearchFriendUseCase: SearchFriendUseCase {
    
    private let friendListRepository: FriendListRepository
    
    init(friendListRepository: FriendListRepository) {
        self.friendListRepository = friendListRepository
    }
    
    func execute(completion: @escaping (Result<FriendList, Error>) -> Void) -> Cancellable? {
        
        return friendListRepository.searchFriendList { result in
            completion(result)
        }
    }
}
