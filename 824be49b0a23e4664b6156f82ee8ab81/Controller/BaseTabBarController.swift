//
//  BaseTabBarController.swift
//  824be49b0a23e4664b6156f82ee8ab81
//
//  Created by Mahmut MERCAN on 3.07.2021.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    var durabilityCurrentValue: Int = 1
    var capacityCurrentValue: Int = 1
    var speedCurrentValue: Int = 1
    var spaceShipName: String?
    
    var favoritePlanets: [SpaceStationModelElement] = []
    var selectedPlanets: [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        print(durabilityCurrentValue, capacityCurrentValue, speedCurrentValue, spaceShipName)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let fvc = segue.destination as? PlanetVC{
        fvc.spaceShipName = self.spaceShipName
        fvc.capacityCurrentValue = self.capacityCurrentValue
        fvc.speedCurrentValue = self.speedCurrentValue
        fvc.durabilityCurrentValue = self.durabilityCurrentValue
        fvc.spaceShipName = self.spaceShipName
        fvc.favoritePlanets = self.favoritePlanets
      }
        if let svc = segue.destination as? FavoritesVC{
          svc.favoritePlanets = self.favoritePlanets
        }

        
    }

    
    
}
