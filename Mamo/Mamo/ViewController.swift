//
//  ViewController.swift
//  Mamo
//
//  Created by Huy Nguyen on 31/05/2021.
//

import UIKit
import FriendList

class SimpleListCell: ListCell<UIColor> {
    override var item: UIColor! { didSet { backgroundColor = item }}
}

class ViewController: ListController<SimpleListCell, UIColor>, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = [.green, .blue, .red, .yellow, .black, .gray, .darkGray, .systemPink]
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
}

