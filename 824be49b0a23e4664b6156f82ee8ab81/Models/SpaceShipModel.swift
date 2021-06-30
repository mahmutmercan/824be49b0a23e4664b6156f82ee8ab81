//
//  SpaceShipModel.swift
//  824be49b0a23e4664b6156f82ee8ab81
//
//  Created by Mahmut MERCAN on 30.06.2021.
//

import Foundation

class SpaceShipModel: NSObject {
    var name: String?
    var speed: Int?
    var materialCapacity: Int?
    var durability: Int?
    var damageCapacity: Int?
    
    init(name: String,
         speed: Int,
         materialCapacity: Int,
         durability:Int,
         damageCapacity: Int) {
        self.name = name
        self.speed = speed
        self.materialCapacity = materialCapacity
        self.durability = durability
        self.damageCapacity = damageCapacity
    }
}
