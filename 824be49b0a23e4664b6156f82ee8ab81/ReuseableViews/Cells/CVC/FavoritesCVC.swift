//
//  FavoritesCVC.swift
//  824be49b0a23e4664b6156f82ee8ab81
//
//  Created by Mahmut MERCAN on 30.06.2021.
//

import UIKit

class FavoritesCVC: UICollectionViewCell {

    static let identifier: String = "FavoritesCVC"
    var favAction: ((UICollectionViewCell) -> Void)?

    @IBOutlet weak var planetNameLabel: UILabel!
    @IBOutlet weak var distanceFromThePlanetLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func cellConfigure(distance: String, planetName: String) {
        distanceFromThePlanetLabel.text = distance
        planetNameLabel.text = planetName
        
    }
    
    static func nib()-> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    @IBAction func followButtonTapped(_ sender: Any) {
        favAction?(self)
    }
}
