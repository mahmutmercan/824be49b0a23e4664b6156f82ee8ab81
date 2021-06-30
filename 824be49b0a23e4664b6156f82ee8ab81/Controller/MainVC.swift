//
//  MainVC.swift
//  824be49b0a23e4664b6156f82ee8ab81
//
//  Created by Mahmut MERCAN on 30.06.2021.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var stationListCV: UICollectionView!
    var layout =  UICollectionViewFlowLayout()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    


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
