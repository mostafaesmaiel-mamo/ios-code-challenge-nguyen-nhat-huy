//
//  FriendListItemViewModel.swift
//  FriendList
//
//  Created by Huy Nguyen on 06/06/2021.
//

import Foundation

struct FriendListItemViewModel: Equatable {
    let publicName: String
}

extension FriendListItemViewModel {
    
    init(friend: Friend) {
        self.publicName = friend.publicName
    }
}
