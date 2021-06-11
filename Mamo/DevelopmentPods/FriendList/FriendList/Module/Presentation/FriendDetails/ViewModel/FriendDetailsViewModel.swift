//
//  FriendDetailsViewModel.swift
//  FriendList
//
//  Created by Huy Nguyen on 11/06/2021.
//

import Foundation

protocol FriendDetailsViewModelInput {
    
}

protocol FriendDetailsViewModelOutput {
    var friendItemViewModel: Observable<FriendListItemViewModel?> { get }
    var screenTitle: String { get }
}

protocol FriendDetailsViewModel: FriendDetailsViewModelInput, FriendDetailsViewModelOutput { }

final class DefaultFriendDetailsViewModel: FriendDetailsViewModel {
    
    // MARK: - OUTPUT
    var friendItemViewModel: Observable<FriendListItemViewModel?> = Observable(nil)
    var screenTitle: String = NSLocalizedString("Selected Contact Information", comment: "")

    init(friendItemViewModel: FriendListItemViewModel) {
        self.friendItemViewModel.value = friendItemViewModel
    }
}
