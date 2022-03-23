//
//  LocationStack.swift
//  RunningLHB
//
//  Created by 刘洪博 on 2021/11/16.
//

import Foundation
import CoreLocation
import MapKit
struct coordi{
    var latitude : Double
    var longitude : Double
}
class LocationQueue
{
   
    var location_stack : [coordi]
    init(){
       
        location_stack = [coordi]()
    }
    func push(current_location : coordi){
            location_stack.append(current_location)
    }
    func pop()->coordi{
        let ans = location_stack[0]
        location_stack.remove(at: 0)
        return ans
    }
}
