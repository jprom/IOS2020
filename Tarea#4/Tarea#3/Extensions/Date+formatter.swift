//
//  Date+formatter.swift
//  Clase#4
//
//  Created by Cesar Brenes on 3/21/20.
//  Copyright © 2020 VeuxLabs. All rights reserved.
//

import Foundation


extension Date {
    
    func getFormatted(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        let localizedDate = formatter.string(from: self)
        return localizedDate
    }
    
}

