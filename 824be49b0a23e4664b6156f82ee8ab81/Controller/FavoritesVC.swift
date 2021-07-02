//
//  FavoritesVC.swift
//  824be49b0a23e4664b6156f82ee8ab81
//
//  Created by Mahmut MERCAN on 30.06.2021.
//

import UIKit

class FavoritesVC: UIViewController {
    
    
    
    @IBOutlet weak var favoritesListCV: UICollectionView!
    var layout =  UICollectionViewFlowLayout()
    
    var favoritePlanets: [SpaceStationModelElement] = []
    
    var durabilityCurrentValue: Int = 0
    var capacityCurrentValue: Int = 0
    var speedCurrentValue: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
    }
    
    @IBAction func showPlanetVC(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PlanetVC") as! PlanetVC
        vc.modalPresentationStyle = .fullScreen
        vc.favoritePlanets = self.favoritePlanets        
        self.present(vc, animated: true)
    }
    
}

extension FavoritesVC {
    private func setupCollectionView() {
        favoritesListCV.backgroundColor = .clear
        favoritesListCV.delegate = self
        favoritesListCV.dataSource = self
        favoritesListCV.isPagingEnabled = true
        favoritesListCV.showsHorizontalScrollIndicator = false
        favoritesListCV.setCollectionViewLayout(layout, animated: true)
        favoritesListCV.register(FavoritesCVC.nib(), forCellWithReuseIdentifier: FavoritesCVC.identifier)
        setupCollectionViewItemSize()
    }
    private func setupCollectionViewItemSize() {
        let screenSize = UIScreen.main.bounds.width
        let itemW: CGFloat = screenSize - 64
        let itemH: CGFloat = (itemW / 2) - 80
        
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func remove(index: Int) {
        favoritePlanets.remove(at: index)
        let indexPath = IndexPath(row: index, section: 0)
        favoritesListCV.performBatchUpdates({
            self.favoritesListCV.deleteItems(at: [indexPath])
        }, completion: {
            (finished: Bool) in
            self.favoritesListCV.reloadItems(at: self.favoritesListCV.indexPathsForVisibleItems)
        })
    }
    
}


extension FavoritesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritePlanets.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesCVC.identifier, for: indexPath) as! FavoritesCVC
        cell.backgroundColor = .red
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.black.cgColor
        cell.favAction  = { (cell) in
            let id = indexPath.row
            print(self.favoritePlanets[id])
            self.remove(index: id)
            
        }
        
        return cell
    }
}
