//
//  data.swift
//  kimView
//
//  Created by dit08 on 2019. 12. 12..
//  Copyright © 2019년 dit. All rights reserved.
//

import Foundation
import MapKit


class data: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    
    init(coordinate: CLLocationCoordinate2D, title: String) {
        self.coordinate = coordinate
        self.title = title
    }
    
    
}

