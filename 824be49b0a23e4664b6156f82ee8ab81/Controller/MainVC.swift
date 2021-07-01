//
//  MainVC.swift
//  824be49b0a23e4664b6156f82ee8ab81
//
//  Created by Mahmut MERCAN on 30.06.2021.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var stationListCV: UICollectionView!
    
    var models = [SpaceStationModelElement]()

    var layout =  UICollectionViewFlowLayout()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupJSON()
        // Do any additional setup after loading the view.
    }
    
    func setupJSON() {
        let jsonUrlString = "https://run.mocky.io/v3/e7211664-cbb6-4357-9c9d-f12bf8bab2e2"
        guard let url = URL(string: jsonUrlString) else
        { return }
        
        URLSession.shared.dataTask(with: url) { [self] (data, response, err) in
            
            guard let data = data else { return }
                    
            do {
               let stations = try JSONDecoder().decode([SpaceStationModelElement].self, from: data)
                self.models.append(contentsOf: stations)
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
        }.resume()
    }
}


extension MainVC {
    private func setupCollectionView() {
        
        stationListCV.backgroundColor = .clear
        stationListCV.delegate = self
        stationListCV.dataSource = self
        stationListCV.isPagingEnabled = true
        stationListCV.showsHorizontalScrollIndicator = false
        stationListCV.setCollectionViewLayout(layout, animated: true)
        stationListCV.register(SpaceStationCVC.nib(), forCellWithReuseIdentifier: SpaceStationCVC.identifier)
        setupCollectionViewItemSize()
        stationListCV.layer.borderWidth = 2
        stationListCV.layer.borderColor = UIColor.black.cgColor
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



extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpaceStationCVC.identifier, for: indexPath) as! SpaceStationCVC
        
        return cell
    }

}
