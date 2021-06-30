//
//  FavoritesVC.swift
//  824be49b0a23e4664b6156f82ee8ab81
//
//  Created by Mahmut MERCAN on 30.06.2021.
//

import UIKit

class FavoritesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    @IBOutlet weak var favoritesListCV: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        favoritesListCV.delegate = self
        favoritesListCV.dataSource = self
        favoritesListCV.register(FavoritesCVC.nib(), forCellWithReuseIdentifier: FavoritesCVC.identifier)

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesCVC.identifier, for: indexPath) as! FavoritesCVC
        cell.backgroundColor = .red
        return cell

    }


}
