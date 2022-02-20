//
//  Geocord.swift
//  GeoCord
//
//  Created by comviva on 19/02/22.


import Foundation
import CoreLocation


public class GeoCord : NSObject, CLLocationManagerDelegate {
    
    var locManager : CLLocationManager?
    public var CurrentLoc : CLLocation?
    var isGrantedPermission=false
  
    public override init() {
        locManager = CLLocationManager()
        locManager?.requestWhenInUseAuthorization()
        locManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
        super.init()
        locManager?.delegate = self
        
    }
    public func startTracking(){
        if isGrantedPermission{
        locManager?.startUpdatingLocation()
        }
    
    }
    
    public func stopTracking() {
        if isGrantedPermission{
            locManager?.stopUpdatingLocation()
           
        }
    }
    public func getCurrentAddress(completion: @escaping (String) -> Void ){
        // geocoding

        let gc = CLGeocoder()
        if let loc = CurrentLoc {
            gc.reverseGeocodeLocation(loc) { (placeResult, err) in

                if let addr = placeResult?.last {
                    let Addr = "\(addr.name ?? ""),\(addr.subLocality ?? ""), \(addr.locality ?? ""),\(addr.administrativeArea ?? ""),\(addr.country ?? ""),\(addr.postalCode ?? " ")"
                    completion(Addr)
                }
            }
        }
    }


    public func getGeoCoordinate(address: String, completion: @escaping (CLLocation) -> Void){
        // forward geocoding
        let gc = CLGeocoder()

        gc.geocodeAddressString(address) { (result, err) in

            if let place = result?.last {
                if let loc = place.location {
                    print("Long:\(loc.coordinate.longitude),Latt:\(loc.coordinate.latitude)")
                    completion(loc)
                }
            }
        }
    }
    // From delegate
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("📍 Updating Location..")
        if let loc = locations.last {
            CurrentLoc = loc
          let long = CurrentLoc?.coordinate.longitude
          let latt = CurrentLoc?.coordinate.latitude
            print("Long :\(long ?? 0) Latt :\(latt ?? 0)")
        }
        
    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status{
        case .denied:
            isGrantedPermission=false
            print("Authorisation Denied")
            
        case .authorizedWhenInUse , .authorizedAlways :
            isGrantedPermission=true
            print("Authorisation Granted")
            locManager?.startUpdatingLocation()
            
        default:
            isGrantedPermission=false
            print("Unknown Error Occured")
        }
        
    }
}
