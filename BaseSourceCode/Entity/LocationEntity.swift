//
//  LocationEntity.swift
//  BaseSourceCode
//
//  Created by hasam on 8/25/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import Foundation

struct LocationEntity {
    var id: Int?
    var name: String?
    var country_name: String?
    var chau_luc: String?
}

extension LocationEntity {
    init(dicData: [String: Any]) {
        self.id = dicData["id"] as? Int
        self.name = dicData["name"] as? String
        self.country_name = dicData["country_name"] as? String
        self.chau_luc = dicData["chau_luc"] as? String
    }
}
