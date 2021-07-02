//
//  PlanetVC.swift
//  824be49b0a23e4664b6156f82ee8ab81
//
//  Created by Mahmut MERCAN on 2.07.2021.
//

import UIKit

class PlanetVC: UIViewController {
    
    var damageCapacity: Int = 100
    var durabilityCurrentValue: Int = 0
    var capacityCurrentValue: Int = 0
    var speedCurrentValue: Int = 0
    
    var EUS: Int = 0
    var UGS: Int = 0
    var DS: Int = 0
    
    @IBOutlet weak var ugsLabel: UILabel!
    @IBOutlet weak var dsLabel: UILabel!
    @IBOutlet weak var eusLabel: UILabel!
    
    @IBOutlet weak var spaceShipNameLabel: UILabel!
    @IBOutlet weak var shipDamageCapacity: UILabel!
    @IBOutlet weak var remainingEusTime: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var currentPlanetNameLabel: UILabel!
    
    var world: SpaceStationModelElement?
    var currentPlanet: SpaceStationModelElement?
    var favoritePlanets: [SpaceStationModelElement] = []
    var selectedPlanets: [Int] = []
    
    var distance: Int = 0
    var distanceResult: Int = 0
    
    @IBOutlet weak var stationListCV: UICollectionView!
    
    var stationResponse = [SpaceStationModelElement]()
    
    var layout =  UICollectionViewFlowLayout()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupJSON()
        setupCalculate()
        currentPlanet = world
        setupCollectionView()
        setInterface()
        
        // Do any additional setup after loading the view.
    }
    
    func setupCalculate() {
        UGS = capacityCurrentValue * 10000
        EUS = speedCurrentValue * 20
        DS = durabilityCurrentValue * 10000
    }
    func setInterface() {
        ugsLabel.text = "UGS: \(UGS)"
        eusLabel.text = "EUS: \(EUS)"
        dsLabel.text = "DS: \(DS)"
        stationListCV.reloadData()
    }
    
    func setupJSON() {
        let jsonUrlString = "https://run.mocky.io/v3/e7211664-cbb6-4357-9c9d-f12bf8bab2e2"
        guard let url = URL(string: jsonUrlString) else
        { return }
        
        URLSession.shared.dataTask(with: url) { [self] (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                let stations = try JSONDecoder().decode([SpaceStationModelElement].self, from: data)
                self.stationResponse.append(contentsOf: stations)
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            DispatchQueue.main.async {
                world = self.stationResponse.first
                currentPlanet = world
                self.stationResponse.removeFirst()
                self.stationListCV.reloadData()
            }
        }.resume()
    }
    
    @IBAction func showFavoritesVC(_ sender: Any) {        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FavoritesVC") as! FavoritesVC
        vc.modalPresentationStyle = .fullScreen
        vc.durabilityCurrentValue = self.durabilityCurrentValue
        vc.capacityCurrentValue = self.capacityCurrentValue
        vc.speedCurrentValue = self.speedCurrentValue
        vc.favoritePlanets = self.favoritePlanets
        
        self.present(vc, animated: true)
    }
    
    
}


extension PlanetVC {
    private func setupCollectionView() {
        
        stationListCV.backgroundColor = .clear
        stationListCV.delegate = self
        stationListCV.dataSource = self
        stationListCV.isPagingEnabled = true
        stationListCV.showsHorizontalScrollIndicator = false
        stationListCV.setCollectionViewLayout(layout, animated: true)
        stationListCV.register(SpaceStationCVC.nib(), forCellWithReuseIdentifier: SpaceStationCVC.identifier)
        setupCollectionViewItemSize()
    }
    
    private func setupCollectionViewItemSize() {
        let screenSize = UIScreen.main.bounds.width / 2
        let itemW: CGFloat = screenSize
        let itemH: CGFloat = itemW
        let minimumLineSpacingValue: CGFloat = itemW / 2
        
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: minimumLineSpacingValue, bottom: 0, right: minimumLineSpacingValue)
        layout.minimumLineSpacing = minimumLineSpacingValue * 2
    }
}

extension PlanetVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stationResponse.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        func distanceCalculation(currentCoordinateX: Double, currentCoordinateY: Double, travelCoordinateX: Double, travelCoordinateY: Double) -> Int {
            var calculateX = (travelCoordinateX - currentCoordinateX) * (travelCoordinateX - currentCoordinateX)
            var calculateY = (travelCoordinateY - currentCoordinateY) * (travelCoordinateY - currentCoordinateY)
            let result = (calculateX + calculateY).squareRoot()
            return Int(result)
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpaceStationCVC.identifier, for: indexPath) as! SpaceStationCVC
        for i in selectedPlanets {
            if indexPath.row == i {
                cell.travelButton.isEnabled = false
            } else {
                cell.travelButton.isEnabled = true
            }
        }
        
        if let planet = currentPlanet {
            distanceResult = distanceCalculation(currentCoordinateX: planet.coordinateX,
                                                 currentCoordinateY: planet.coordinateY,
                                                 travelCoordinateX: stationResponse[indexPath.row].coordinateX,
                                                 travelCoordinateY: stationResponse[indexPath.row].coordinateY)
        } else {
            print("Doesn’t found a planet")
        }
        cell.cellConfigure(capacity: String(stationResponse[indexPath.row].capacity), need: String(stationResponse[indexPath.row].need), distance: String(distanceResult), planetName: stationResponse[indexPath.row].name)
        
        cell.favAction = { (cell) in
            let id = indexPath.row
            print(self.stationResponse[id])
            self.favoritePlanets.append(self.stationResponse[id])
            
                        
        }
        
        cell.travelAction = { [self] (cell) in
            print("travel tapped")
            self.selectedPlanets.append(indexPath.row)
            print(self.selectedPlanets.count)
            print(self.selectedPlanets)
            currentPlanet = stationResponse[indexPath.row]
            currentPlanetNameLabel.text = currentPlanet?.name
            EUS = EUS - distanceResult
            UGS = UGS - stationResponse[indexPath.row].need
            self.stationListCV.reloadData()
            print("EUS: \(EUS) VE UGS: \(UGS)")
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.stationListCV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpaceStationCVC.identifier, for: indexPath) as! SpaceStationCVC
            
            for i in selectedPlanets {
                if indexPath.row == i {
                    cell.travelButton.isEnabled = false
                } else {
                    cell.travelButton.isEnabled = true
                }
            }
        }
    }
}

extension PlanetVC: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
}

