//
//  FriendListItemCell.swift
//  FriendList
//
//  Created by Huy Nguyen on 06/06/2021.
//

import Foundation

final class FriendListItemCell: ListCell<FriendListItemViewModel> {
    
    override var item: FriendListItemViewModel! {
        didSet {
            viewModel = item
        }
    }
    
    private var viewModel: FriendListItemViewModel!
    
    func fill(with viewModel: FriendListItemViewModel) {
        self.viewModel = viewModel

        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.releaseDate
        overviewLabel.text = viewModel.overview
        updatePosterImage(width: Int(posterImageView.imageSizeAfterAspectFit.scaledSize.width))
    }
}
