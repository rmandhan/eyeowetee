//
//  ViewController.swift
//  Eye Owe Tee
//
//  Created by Rakesh Mandhan on 2018-03-07.
//  Copyright © 2018 Rakesh Mandhan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var gridView: GridView!
    @IBOutlet weak var gridViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Start timer for now
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.updateUserLocation), userInfo: nil, repeats: true)
    }

    @objc func updateUserLocation() {
        if let dimensions = gridView.gridDimensions {
            let x = Int(arc4random_uniform(UInt32(dimensions.x + 1)))
            let y = Int(arc4random_uniform(UInt32(dimensions.y + 1)))
            gridView.location = CGPoint(x: x, y: y)
            gridView.setNeedsDisplay()
        }
    }
}

