//
//  SpaceStationModel.swift
//  824be49b0a23e4664b6156f82ee8ab81
//
//  Created by Mahmut MERCAN on 30.06.2021.
//

import Foundation

// MARK: - SpaceStationModelElement
struct SpaceStationModelElement: Codable {
    let name: String
    let coordinateX: Double
    let coordinateY: Double
    let capacity: Int
    let stock: Int
    let need: Int
}

typealias SpaceStationModel = [SpaceStationModelElement]
