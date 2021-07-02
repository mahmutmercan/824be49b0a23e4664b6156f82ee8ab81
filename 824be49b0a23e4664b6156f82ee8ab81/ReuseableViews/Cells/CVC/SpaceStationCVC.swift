//
//  SpaceStationCVC.swift
//  824be49b0a23e4664b6156f82ee8ab81
//
//  Created by Mahmut MERCAN on 30.06.2021.
//

import UIKit

class SpaceStationCVC: UICollectionViewCell {

    static let identifier: String = "SpaceStationCVC"

    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var travelButton: UIButton!
    @IBOutlet weak var stockNeedLabel: UILabel!
    @IBOutlet weak var distanceFromThePlanetLabel: UILabel!
    @IBOutlet weak var planetLabel: UILabel!
    
    var travelAction: ((UICollectionViewCell) -> Void)?
    var favAction: ((UICollectionViewCell) -> Void)?


    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .cyan
        setupCell()
        // Initialization code
    }
    func setupCell() {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 12

    }
    func cellConfigure(capacity: String, need: String, distance: String, planetName: String) {
        stockNeedLabel.text = "\(capacity)/\(need)"
        distanceFromThePlanetLabel.text = "\(distance) EUS"
        planetLabel.text = String(planetName)
    }

    @IBAction func followButtonTapped(_ sender: Any) {
        favAction?(self)
        if #available(iOS 13.0, *) {
            if favoriteButton.imageView?.image == UIImage(systemName: "Star") {
                favoriteButton.imageView?.image = UIImage(systemName: "Star.fill")
            } else {
                favoriteButton.imageView?.image = UIImage(systemName: "Star")
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    @IBAction func travelButtonTapped(_ sender: Any) {
        travelAction?(self)
    }
    
    
    static func nib()-> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

}
