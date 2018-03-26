//
//  ViewController.swift
//  Eye Owe Tee
//
//  Created by Rakesh Mandhan on 2018-03-07.
//  Copyright © 2018 Rakesh Mandhan. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var gridView: GridView!
    @IBOutlet weak var gridViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var debugView: UITextView!
    
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: UUID.init(uuidString: "636f3f8f-6491-4bee-95f7-d8cc64a863b5")!, identifier: "Rasps")

    override func viewDidLoad() {
        super.viewDidLoad()
        debugView.isHidden = true
        locationManager.delegate = self
        if (CLLocationManager.authorizationStatus() != .authorizedWhenInUse) {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startRangingBeacons(in: region)
    }

    // We are willing to become first responder to get shake motion
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
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
//        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.updateUserLocation), userInfo: nil, repeats: true)
    }
    
    // Enable detection of shake motion
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if (motion == .motionShake) {
            debugView.isHidden = !debugView.isHidden
        }
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

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        print(beacons)
        if (!debugView.isHidden) {
            debugView.text.append("\(beacons)\n")
            let range = NSMakeRange(NSString(string: debugView.text).length - 1, 1)
            debugView.scrollRangeToVisible(range)
        }
    }
}

