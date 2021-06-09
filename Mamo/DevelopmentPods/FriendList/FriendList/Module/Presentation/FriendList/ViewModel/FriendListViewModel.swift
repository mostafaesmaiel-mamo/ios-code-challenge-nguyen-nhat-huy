//
//  FriendListViewModel.swift
//  FriendList
//
//  Created by Huy Nguyen on 07/06/2021.
//

import Foundation

struct FriendListViewModelActions {
    let showFriendDetails: (Friend) -> Void
    let showFriendQueriesSuggestions: (@escaping (_ didSelect: FriendQuery) -> Void) -> Void
    let closeFriendQueriesSuggestions: () -> Void
}

protocol FriendListViewModelInput {
    func viewDidLoad()
    func didSearch(query: String)
    func didCancelSearch()
    func showQueriesSuggestions()
    func closeQueriesSuggestions()
    func didSelectItem(at index: Int)
}

protocol FriendListViewModelOutput {
    var items: Observable<[FriendListItemViewModel]> { get }
    var query: Observable<String> { get }
    var error: Observable<String> { get }
    var isEmpty: Bool { get }
    var screenTitle: String { get }
    var emptyDataTitle: String { get }
    var errorTitle: String { get }
    var searchBarPlaceholder: String { get }
}

protocol FriendListViewModel: FriendListViewModelInput, FriendListViewModelOutput {}

final class DefaultFriendListViewModel: FriendListViewModel {
    
    private let fetchFriendFrequentsUseCase: FetchFriendsFrequentUseCase
    private let actions: FriendListViewModelActions?
    
    private var friendListLoadTask: Cancellable? { willSet { friendListLoadTask?.cancel() } }
    
    // MARK: - OUTPUT
    
    let items: Observable<[FriendListItemViewModel]> = Observable([])
    let query: Observable<String> = Observable("")
    let error: Observable<String> = Observable("")
    var isEmpty: Bool { return items.value.isEmpty }
    let screenTitle = NSLocalizedString("Friends", comment: "")
    let emptyDataTitle = NSLocalizedString("Search results", comment: "")
    let errorTitle = NSLocalizedString("Error", comment: "")
    let searchBarPlaceholder = NSLocalizedString("Search Friends", comment: "")
    
    // MARK: - Init
    
    init(fetchFriendFrequentsUseCase: FetchFriendsFrequentUseCase,
         actions: FriendListViewModelActions? = nil) {
        self.fetchFriendFrequentsUseCase = fetchFriendFrequentsUseCase
        self.actions = actions
    }
    
    private func handle(error: Error) {
        self.error.value = NSLocalizedString("Failed loading friends", comment: "")
    }
}

extension DefaultFriendListViewModel {
    
    func viewDidLoad() {
        fetchFriendFrequentsUseCase.execute(completion: { result in
            switch result {
            case .success(let friendFrequents):
                var friendListItem = [FriendListItemViewModel]()
                friendFrequents.friends.forEach {
                    friendListItem.append(FriendListItemViewModel(friend: $0))
                }
                self.items.value.append(contentsOf: (friendListItem))
            case .failure(let error):
                self.handle(error: error)
            }
        })
    }
    
    func didSearch(query: String) {
        
    }
    
    func didCancelSearch() {
        
    }
    
    func showQueriesSuggestions() {
        
    }
    
    func closeQueriesSuggestions() {
        
    }
    
    func didSelectItem(at index: Int) {
        
    }
}
