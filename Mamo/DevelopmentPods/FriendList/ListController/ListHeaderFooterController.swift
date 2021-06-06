//
//  ListHeaderFooterController.swift
//  FriendList
//
//  Created by Huy Nguyen on 04/06/2021.
//

import UIKit

open class ListHeaderFooterController<T: ListCell<U>, U, H: UICollectionReusableView, F: UICollectionReusableView>: UICollectionViewController {
    
    open var items = [U]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    fileprivate let cellId = "cellId"
    fileprivate let supplementaryViewId = "supplementaryViewId"
    
    open func estimatedCellHeight(for indexPath: IndexPath, cellWidth: CGFloat) -> CGFloat {
        let cell = T()
        let largeHeight: CGFloat = 1000
        cell.frame = .init(x: 0, y: 0, width: cellWidth, height: largeHeight)
        cell.item = items[indexPath.item]
        cell.layoutIfNeeded()
        
        return cell.systemLayoutSizeFitting(.init(width: cellWidth, height: largeHeight)).height
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        #if os(iOS)
        if #available(iOS 13.0, *) {
            collectionView.backgroundColor = .systemBackground
        } else {
            collectionView.backgroundColor = .white
        }
        #endif
        
        collectionView.register(T.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(H.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: supplementaryViewId)
        collectionView.register(F.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: supplementaryViewId)
    }
    
    override open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! T
        cell.item = items[indexPath.row]
        return cell
    }
    
    open func setupHeader(_ header: H) {}
    
    open func setupFooter(_ footer: F) {}
    
    override open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: supplementaryViewId, for: indexPath)
        if let header = supplementaryView as? H {
            setupHeader(header)
        } else if let footer = supplementaryView as? F {
            setupFooter(footer)
        }
        return supplementaryView
    }
    
    override open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override open func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        view.layer.zPosition = -1
    }
    
    public init(layout: UICollectionViewLayout = UICollectionViewFlowLayout(), scrollDirection: UICollectionView.ScrollDirection = .vertical) {
        if let layout = layout as? UICollectionViewFlowLayout {
            layout.scrollDirection = scrollDirection
        }
        super.init(collectionViewLayout: layout)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
