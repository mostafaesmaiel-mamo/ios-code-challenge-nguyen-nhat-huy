//
//  FriendListItemViewModel.swift
//  FriendList
//
//  Created by Huy Nguyen on 06/06/2021.
//

import Foundation

struct FriendListItemViewModel: Equatable {
    let id: String
    let key: String?
    let value: String?
    let publicName: String
    let isMamoOrFrequents: Bool
    let imageData: Data?
}

extension FriendListItemViewModel {
    
    init(friend: Friend) {
        self.id = friend.id
        self.key = friend.key
        self.value = friend.value
        self.publicName = friend.publicName
        self.isMamoOrFrequents = friend.isMamoOrFrequents
        self.imageData = friend.imageData
    }
}
