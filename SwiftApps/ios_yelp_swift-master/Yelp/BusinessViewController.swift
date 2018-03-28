//
//  BusinessViewController.swift
//  Yelp
//
//  Created by Kevin Nguyen on 3/23/18.
//  Copyright © 2018 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class BusinessViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var businessLocation: MKMapView!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var typeOfFood: UILabel!
    var business: Business?
    
    @IBOutlet weak var businessAddress: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        businessName.text = business?.name!
        let lat = business?.latitude
        let long = business?.longitude
        let url = business?.imageURL!
        backgroundImage.setImageWith(url!)
        businessAddress.text = business?.address
        typeOfFood.text = business?.categories
        phoneNumber.text = business?.phoneNumber
        // Do any additional setup after loading the view.
        let centerLocation = CLLocation(latitude: lat!, longitude: long!)
        goToLocation(location: centerLocation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goToLocation(location: CLLocation) {
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        businessLocation.setRegion(region, animated: false)
    }
}
