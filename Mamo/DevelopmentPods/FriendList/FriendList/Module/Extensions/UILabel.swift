//
//  UILabel.swift
//  FriendList
//
//  Created by Huy Nguyen on 06/06/2021.
//

import Foundation

extension UILabel {
    convenience public init(text: String? = nil, font: UIFont? = UIFont.systemFont(ofSize: 14), textColor: UIColor = .black, textAlignment: NSTextAlignment = .left, numberOfLines: Int = 1) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
    }
}

extension String {
    func imageWithFirstCharacter() -> UIImage? {
        let frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        let nameLabel = UILabel(text: nil,
                            font: .boldSystemFont(ofSize: 24),
                            textColor: .white,
                            textAlignment: .center)
        nameLabel.frame = frame
        nameLabel.backgroundColor = .red
        guard let firstChar = self.first else {
            return nil
        }
        nameLabel.text = String(firstChar).capitalized
        UIGraphicsBeginImageContext(frame.size)
        if let currentContext = UIGraphicsGetCurrentContext() {
            nameLabel.layer.render(in: currentContext)
            let nameImage = UIGraphicsGetImageFromCurrentImageContext()
            return nameImage
        }
        return nil
    }
}
