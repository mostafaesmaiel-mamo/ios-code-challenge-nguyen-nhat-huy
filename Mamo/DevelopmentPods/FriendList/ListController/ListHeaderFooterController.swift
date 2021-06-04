//
//  ListHeaderFooterController.swift
//  FriendList
//
//  Created by Huy Nguyen on 04/06/2021.
//

import UIKit

open class ListHeaderFooterController<T: ListCell<U>, U, H: UICollectionReusableView, F: UICollectionReusableView>: UICollectionReusableView {
    
    open var items = [U]() {
        didSet {
            Dispa
        }
    }
}
