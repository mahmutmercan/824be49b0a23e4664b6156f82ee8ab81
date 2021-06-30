//
//  ViewController.swift
//  824be49b0a23e4664b6156f82ee8ab81
//
//  Created by Mahmut MERCAN on 30.06.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setButton()
    }
    func setButton() {
        playButton.layer.borderWidth = 2
        playButton.layer.borderColor = UIColor.black.cgColor
    }

    @IBAction func playButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toMainVC", sender: sender)
    }
    
}

