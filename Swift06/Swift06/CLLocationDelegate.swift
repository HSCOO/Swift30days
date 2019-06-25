//
//  CLLocationDelegate.swift
//  Swift06
//
//  Created by 胡生才 on 2019/6/25.
//  Copyright © 2019 胡生才. All rights reserved.
//

import Foundation
import CoreLocation


// 代理可以单独写一个类实现
extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.desLabel.text = "Error while updating location " + error.localizedDescription
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(locations.first!) { (placemarks, error) in
            guard error == nil else{
                self.desLabel.text = "Reverse gepcoder failed with error" + error!.localizedDescription
                return
            }
            
            if placemarks!.count > 0 {
                let pm = placemarks?.first
                self.displayLocationInfo(pm)
            }else{
                self.desLabel.text = "Problem with the data receive from geocoder"
            }
        }
    }
    
    func displayLocationInfo(_ placemark: CLPlacemark?) {
        if let containsPlacemark = placemark {
            
            locationManager.stopUpdatingLocation()
            
            let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
            let postalCode = containsPlacemark.postalCode != nil ? containsPlacemark.postalCode : ""
            let administrativeArea = containsPlacemark.administrativeArea != nil ? containsPlacemark.administrativeArea : ""
            let country = containsPlacemark.country != nil ? containsPlacemark.country : ""
            
            self.desLabel.text = postalCode! + " " + locality!
            self.desLabel.text?.append("\n" + administrativeArea! + "," + country!)
            
        }
    }
}
