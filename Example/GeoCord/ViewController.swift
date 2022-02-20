//
//  ViewController.swift
//  GeoCord
//
//  Created by talk2uttam14 on 02/19/2022.
//  Copyright (c) 2022 talk2uttam14. All rights reserved.
//

import UIKit
import GeoCord

class ViewController: UIViewController {
    @IBOutlet weak var ifoL: UILabel!
    let location = GeoCord()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func stopB(_ sender: Any) {
        location.stopTracking()
        print("Tracking stopped...")
        
    }
    @IBAction func startB(_ sender: Any) {
        location.startTracking()
        print("Tracking started...")
        updateinfo()
    }
    @IBAction func showCord(_ sender: Any) {
        location.getGeoCoordinate(address: "Banglore") { (loc) in
            self.ifoL.text="Banglore Long : \(loc.coordinate.longitude), Latt: \(loc.coordinate.latitude)"
            print("Banglore Long : \(loc.coordinate.longitude), Latt: \(loc.coordinate.latitude)")
        }
    }
    
    @IBAction func showAdd(_ sender: Any) {
        location.getCurrentAddress { (addr) in
            self.ifoL.text="Current Address :\(addr)"
            print(addr)
        }
    }
    public func updateinfo(){
        if let loc = location.CurrentLoc{
            let latt = loc.coordinate.latitude
            let long = loc.coordinate.longitude
            ifoL.text="Longitude:\(long) Latitude:\(latt)"
            print("Long:\(long) Latt:\(latt)")
        }
        else {
            print("No location found")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

