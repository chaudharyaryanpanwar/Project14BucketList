//
//  Location.swift
//  Project14BucketList
//
//  Created by Aryan Panwar on 12/08/24.
//

import Foundation
import MapKit

struct Location : Codable , Equatable , Identifiable {
    var id : UUID
    var name : String
    var description : String
    var latitude : Double
    var longitude  : Double 
    
    var coordinate : CLLocationCoordinate2D{
        CLLocationCoordinate2D(latitude : self.latitude , longitude : self.longitude)
    }
    
    static func == (lhs : Location  , rhs : Location) -> Bool {
        lhs.id == rhs.id 
    }
    
    #if DEBUG
    static let example = Location(id : UUID() , name : "Buckingham Palace" , description: "Lit by over 40000 bulbs" , latitude: 51.501 , longitude: -0.141)
    #endif
}
