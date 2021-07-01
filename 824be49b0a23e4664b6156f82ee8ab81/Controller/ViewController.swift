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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSliders()
        calculateTotalPoints()
        // Do any additional setup after loading the view.
    }
    

    
    func setupSliders(){
        let sliders = [durabilitySlider, capacitySlider, speedSlider]
        for i in sliders {
            i?.maximumValue = 13.0
            i?.minimumValue = 1.0
        }
    }
    
    func calculateTotalPoints(){
        totalPoint = durabilityCurrentValue + capacityCurrentValue + speedCurrentValue
        if totalPoint  <= 15 {
            let value = String(15 - totalPoint)
            distributedPoint.text = value
        } else {
            print(String(totalPoint) + String("is more then 15"))
        }
    }

    @IBAction func playButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toMainVC", sender: sender)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMainVC" {
            if let destinationVC = segue.destination as? MainVC {
                destinationVC.durabilityCurrentValue = self.durabilityCurrentValue
                destinationVC.capacityCurrentValue = self.capacityCurrentValue
                destinationVC.speedCurrentValue = self.speedCurrentValue
            }
        }
    }
    
    @IBAction func durabilitySliderValueChanged(_ sender: UISlider) {
        durabilityCurrentValue = Int(round(sender.value))
        print(sender.value)
        print(durabilityCurrentValue)
        calculateTotalPoints()
    }
    @IBAction func speedSliderValueChanged(_ sender: UISlider) {
        speedCurrentValue = Int(round(sender.value))
        print(sender.value)
        print(speedCurrentValue)
        calculateTotalPoints()
    }
    @IBAction func capacitySliderValueChanged(_ sender: UISlider) {
        capacityCurrentValue = Int(round(sender.value))
        print(sender.value)
        print(capacityCurrentValue)
        calculateTotalPoints()
    }
}

