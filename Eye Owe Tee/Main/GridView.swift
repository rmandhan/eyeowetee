//
//  GridView.swift
//  Eye Owe Tee
//
//  Created by Rakesh Mandhan on 2018-03-12.
//  Copyright © 2018 Rakesh Mandhan. All rights reserved.
//

import UIKit

class GridView: UIView {
    
    let roomWidth: Float = 100.0
    let roomLength: Float = 140.0
    let lineSpacing: Float = 6.0
    let circleWidth: Double = 12.0
    var widthPixels: Float = 0
    var heightPixels: Float = 0
    var gridDimensions: CGPoint!
    var location: CGPoint!
    
    override func draw(_ rect: CGRect) {
        let roomRatio: Float = roomLength/roomWidth
        // Translate room dimensions to pixels
        widthPixels = Float(bounds.width)
        heightPixels = roomRatio*widthPixels
        let numVerticalLines: Int = Int(widthPixels/lineSpacing)
        let numHorizontalLines: Int = Int(Float(numVerticalLines)*roomRatio) + 1
        let offset: Float = 1.0
        
        let linePath = UIBezierPath()
        linePath.lineWidth = 1.0
        
        // Draw the vertical lines
        for index in 0...numVerticalLines
        {
            let x = CGFloat(Float(index)*lineSpacing + offset)
            let start = CGPoint(x: x, y: 0)
            let end = CGPoint(x: x, y: CGFloat(heightPixels))
            linePath.move(to: start)
            linePath.addLine(to: end)
        }
        // Draw the horizontal lines
        for index in 0...numHorizontalLines
        {
            let y = CGFloat(Float(index)*lineSpacing + offset)
            let start = CGPoint(x: 0, y: y)
            let end = CGPoint(x: CGFloat(widthPixels), y: y)
            linePath.move(to: start)
            linePath.addLine(to: end)
        }
        
        UIColor.lightGray.setStroke()
        linePath.stroke()
        linePath.close()
        
        // Just place iBeacons in the corners of the rooms by default -> 4 iBeacons
        drawCircle(x: 0, y: 0, colour: UIColor.red)
        drawCircle(x: Double(bounds.width) - circleWidth, y: 0, colour: UIColor.red)
        drawCircle(x: 0, y: Double(heightPixels) - circleWidth, colour: UIColor.red)
        drawCircle(x: Double(widthPixels) - circleWidth, y: Double(heightPixels) - circleWidth, colour: UIColor.red)
        
        // Draw user's location
        if (location != nil) {
            drawCircle(x: Double(((Float(location.x-1)*lineSpacing))), y: Double(((Float(location.y-1)*lineSpacing))), colour: UIColor.green)
        }
        
        // Set the grid dimensions
        gridDimensions = CGPoint(x: numVerticalLines, y: numHorizontalLines)
    }
    
    func drawCircle(x: Double, y: Double, colour: UIColor) {
        // Make sure the coordinates fall within the range, otherwise set them to a corner
        var filteredX: Double = x
        var filteredY: Double = y
        if (x < 0) {
            filteredX = 0
        } else if (x > Double(widthPixels)) {
            filteredX = Double(widthPixels) - circleWidth
        }
        if (y < 0) {
            filteredY = 0
        } else if (y > Double(heightPixels)) {
            filteredY = Double(heightPixels) - circleWidth
        }
        
        let circlePath = UIBezierPath(ovalIn: CGRect(x: filteredX, y: filteredY, width: circleWidth, height: circleWidth))
        UIColor.black.setStroke()
        colour.setFill()
        circlePath.stroke()
        circlePath.fill()
        circlePath.close()
    }

}
