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
    var stateFavorites = 1
    
    
    var spaceShipName: String?
    
    var distance: Int = 0
    var distanceResult: Int = 0
    var stationResponse = [SpaceStationModelElement]()
    
    
    var layout =  UICollectionViewFlowLayout()
    @IBOutlet weak var stationListCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTBC()
        setInterface()
        setupJSON()
        currentPlanet = world
        setupCollectionView()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupCalculate()
    }
    func setTBC() {
        durabilityCurrentValue = (self.tabBarController as? BaseTabBarController)!.durabilityCurrentValue
        capacityCurrentValue = (self.tabBarController as? BaseTabBarController)!.capacityCurrentValue
        speedCurrentValue = (self.tabBarController as? BaseTabBarController)!.speedCurrentValue
        spaceShipName = (self.tabBarController as? BaseTabBarController)!.spaceShipName
        
    }
    
    func setInterface() {
        //        self.tabBarController?.selectedViewController
        spaceShipNameLabel.text = self.spaceShipName
        setupCalculate()
        ugsLabel.text = "UGS: \(UGS)"
        eusLabel.text = "EUS: \(EUS)"
        dsLabel.text = "DS: \(DS)"
        shipDamageCapacity.layer.borderWidth = 2
        shipDamageCapacity.layer.borderColor = UIColor.black.cgColor
        remainingEusTime.layer.borderWidth = 2
        remainingEusTime.layer.borderColor = UIColor.black.cgColor
        
    }
    
    func setupCalculate() {
        UGS = self.capacityCurrentValue * 10000
        EUS = self.speedCurrentValue * 20
        DS = self.durabilityCurrentValue * 10000
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FavoritesVC{
            print("fav: \(favoritePlanets)")
            vc.favoritePlanets = self.favoritePlanets
            vc.distanceResult = self.distanceResult
        }
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
        
        if let planet = currentPlanet {
            distanceResult = distanceCalculation(currentCoordinateX: planet.coordinateX,
                                                 currentCoordinateY: planet.coordinateY,
                                                 travelCoordinateX: stationResponse[indexPath.row].coordinateX,
                                                 travelCoordinateY: stationResponse[indexPath.row].coordinateY)
        } else {
            print("Doesn’t found a planet")
        }
        
        cell.cellConfigure(capacity: String(stationResponse[indexPath.row].capacity),
                           need: String(stationResponse[indexPath.row].need),
                           distance: String(distanceResult),
                           planetName: stationResponse[indexPath.row].name)
        cell.favAction = { [self] (cell) in
            self.favoritePlanets.append(self.stationResponse[indexPath.row])
            self.stationListCV.reloadData()
        }
        
        cell.travelAction = { [self] (cell) in
            print("travel tapped")
            self.selectedPlanets.append(indexPath.row)
            currentPlanet = stationResponse[indexPath.row]
            currentPlanetNameLabel.text = currentPlanet?.name
            EUS = EUS - distanceResult
            UGS = UGS - stationResponse[indexPath.row].need
            ugsLabel.text = "UGS: \(UGS)"
            eusLabel.text = "EUS: \(EUS)"
            dsLabel.text = "DS: \(DS)"
            self.stationListCV.reloadData()
            print("EUS: \(EUS) VE UGS: \(UGS)")
        }
        if selectedPlanets.contains(indexPath.row) {
            cell.travelButton.isEnabled = false
        } else {
            cell.travelButton.isEnabled = true
        }
        return cell
    }
}

extension PlanetVC: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
}

