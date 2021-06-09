//
//  DefaultFriendListRepository.swift
//  FriendList
//
//  Created by Huy Nguyen on 08/06/2021.
//

import Foundation
import Networking

protocol FriendListRepository {
    @discardableResult
    func fetchFriendFrequentList(completion: @escaping (Result<FriendFrequents, Error>) -> Void) -> Cancellable?
}

final class DefaultFriendListRepository {
    
    private let apiDataTransferService: APIDataTransferService
    
    init(apiDataTransferService: APIDataTransferService) {
        self.apiDataTransferService = apiDataTransferService
    }
}

extension DefaultFriendListRepository: FriendListRepository {
    
    func fetchFriendFrequentList(completion: @escaping (Result<FriendFrequents, Error>) -> Void) -> Cancellable? {
        let task = RepositoryTask()
        
        let endpoint = APIEndpoints.getListFrequents()
        task.networkTask = self.apiDataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                completion(.success(response.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        return task
    }
}
