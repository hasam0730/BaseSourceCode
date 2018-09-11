//
//  Date+Extension.swift
//  BaseSourceCode
//
//  Created by mac mini on 9/11/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import Foundation

extension Date {
    func convertDateToString(format: String = "HH:mm dd/MM/yyyy") -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+7:00")
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}
