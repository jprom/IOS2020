//
//  Date+Formatter.swift
//  ProyectoPresupuesto
//
//  Created by Juan Pablo Rosales on 4/15/20.
//  Copyright © 2020 Juan Pablo Rosales. All rights reserved.
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
