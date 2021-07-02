//
//  Utils.swift
//  824be49b0a23e4664b6156f82ee8ab81
//
//  Created by Mahmut MERCAN on 1.07.2021.
//

import UIKit

extension Int {
    func firstDistanceCalculation(currentCoordinateX: Double, currentCoordinateY: Double, travelCoordinateX: Double, travelCoordinateY: Double) -> Int {
        let calculateX = (travelCoordinateX - currentCoordinateX) * (travelCoordinateX - currentCoordinateX)
        let calculateY = (travelCoordinateY - currentCoordinateY) * (travelCoordinateY - currentCoordinateY)
        let result = (calculateX + calculateY).squareRoot()
        return Int(result)
    }

}
