//
//  Julian_Boyko_iOS_Developer_AddressDetailVC.swift
//  Julian_Boyko_Prepr_Challenge
//
//  Created by Julian Boyko on 2020-03-21.
//  Copyright © 2020 Supreme Apps. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class Julian_Boyko_iOS_Developer_AddressDetailVC: UIViewController {
    
    // MARK: Attributes

    @IBOutlet weak var viewForMap: UIView!
    @IBOutlet weak var addressTitleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    var passedInAddress: Address?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAttributes()
        getLonLatAndSetUpMap()
    }
    
    func setUpAttributes() {
        Utilities.styleFilledButton(backButton)
        if passedInAddress != nil {
            addressTitleLabel.text = passedInAddress!.name + "'s Address"
        }
    }
    
    func getLonLatAndSetUpMap() {
        // First get long and lat from address
        let geocoder = CLGeocoder()
        var lat: CLLocationDegrees?
        var lon: CLLocationDegrees?
        geocoder.geocodeAddressString(passedInAddress!.getAddress()) { (placemarkers, error) in
            print(self.passedInAddress!.getAddress())
            let placemark = placemarkers?.first
            if placemark?.location != nil {
                lat = (placemark?.location?.coordinate.latitude)!
                lon = (placemark?.location?.coordinate.longitude)!
                
                self.setUpGoogleMap(lat: lat, lon: lon)
            } else {
                self.addressTitleLabel.displayError("Failed mapping address: " + self.passedInAddress!.getAddress())
            }
        }
    }
    
    func setUpGoogleMap(lat: CLLocationDegrees?, lon: CLLocationDegrees?) {
        if lat != nil && lon != nil {
            let camera = GMSCameraPosition.camera(withLatitude: lat!, longitude: lon!, zoom: 15.0)
            let mapView = GMSMapView.map(withFrame: viewForMap.frame, camera: camera)
            view.addSubview(mapView)
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: lat!, longitude: lon!)
            marker.title = passedInAddress!.name + "'s Address"
            marker.snippet = passedInAddress!.getAddress()
            marker.map = mapView
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
