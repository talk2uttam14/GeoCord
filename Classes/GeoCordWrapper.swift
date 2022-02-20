//
//  GeoCordWrapper.swift
//  GeoCord
//
//  Created by comviva on 19/02/22.
//

import Foundation
import CoreLocation

public class GeoCordWrapper{
    
    let utility = GeoCord()

    public init(){}

    public func startTracking() {
        utility.startTracking()
    }
    public func stopTracking(){
        utility.stopTracking()
    }

    public func getCurrentLocation() -> CLLocation? {
        return utility.CurrentLoc
    }

    public func getCurrentAddress(completion: @escaping (String) -> Void ){
        // geocoding

        let gc = CLGeocoder()
        if let loc = utility.CurrentLoc {
            gc.reverseGeocodeLocation(loc) { (placeResult, err) in

                if let addr = placeResult?.first {
                    let Address = "\(addr.subLocality ?? ""), \(addr.locality ?? ""),  \(addr.administrativeArea ?? ""),\(addr.country ?? "")"

                    print("Address: \(Address)")
                    completion(Address)
                }
            }
        }
    }


    public func getGeoCoord(address: String, completion: @escaping (CLLocation) -> Void){
        // forward geocoding
        let gc = CLGeocoder()

        gc.geocodeAddressString(address) { (result, err) in

            if let place = result?.first {
                if let loc = place.location {
                    print("Lat:\(loc.coordinate.latitude)")
                    completion(loc)
                }
            }
        }
    }
}
