//
//  ViewController.swift
//  824be49b0a23e4664b6156f82ee8ab81
//
//  Created by Mahmut MERCAN on 30.06.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var distributedPointLabel: UILabel!
    @IBOutlet weak var distributedPoint: UILabel!
    @IBOutlet weak var spaceShipNameField: UITextField!
    
    @IBOutlet weak var durabilitySlider: UISlider!
    @IBOutlet weak var capacitySlider: UISlider!
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var playButton: UIButton!
    
    var totalPoint: Int = 0
    var durabilityCurrentValue: Int = 1
    var capacityCurrentValue: Int = 1
    var speedCurrentValue: Int = 1
    let maxSum: Float = 15
    
    var spaceShipName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSliders()
        if #available(iOS 12.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
                playButton.tintColor = UIColor.white
            } else {
                playButton.tintColor = UIColor.black
            }
        } else {
            // Fallback on earlier versions
        }

        // Do any additional setup after loading the view.
    }    
    func setupSliders(){
        let sliders = [durabilitySlider, capacitySlider, speedSlider]
        for i in sliders {
            i?.maximumValue = 13.0
            i?.minimumValue = 1.0
        }
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if #available(iOS 12.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
                playButton.tintColor = UIColor.white
            } else {
                playButton.tintColor = UIColor.black
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let sum = durabilitySlider.value + capacitySlider.value + speedSlider.value // better: use outlet collection
        distributedPoint.text = String(Int(round(maxSum - sum)))
        if (sum > maxSum) {
            let overflow = sum - maxSum
            sender.value = sender.value - overflow
            distributedPoint.text = "0"
        }
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toTBC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tbc = segue.destination as? BaseTabBarController {
            spaceShipName = spaceShipNameField.text
            tbc.capacityCurrentValue = self.capacityCurrentValue
            tbc.speedCurrentValue = self.speedCurrentValue
            tbc.durabilityCurrentValue = self.durabilityCurrentValue
            tbc.spaceShipName = self.spaceShipName
        }
    }
    
    @IBAction func durabilitySliderValueChanged(_ sender: UISlider) {
        durabilityCurrentValue = Int(round(sender.value))
    }
    
    @IBAction func speedSliderValueChanged(_ sender: UISlider) {
        speedCurrentValue = Int(round(sender.value))
    }
    
    @IBAction func capacitySliderValueChanged(_ sender: UISlider) {
        capacityCurrentValue = Int(round(sender.value))
    }
}
