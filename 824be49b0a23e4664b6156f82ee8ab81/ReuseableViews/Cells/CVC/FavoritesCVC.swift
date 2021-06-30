//
//  FavoritesCVC.swift
//  824be49b0a23e4664b6156f82ee8ab81
//
//  Created by Mahmut MERCAN on 30.06.2021.
//

import UIKit

class FavoritesCVC: UICollectionViewCell {

    static let identifier: String = "FavoritesCVC"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib()-> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

}
