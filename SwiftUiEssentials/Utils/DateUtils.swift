//
//  Utils.swift
//  SwiftUiEssentials
//
//  Created by Amit on 21/09/2024.
//

import Foundation

struct DateUtils {
    
    // Helper function to get the date as a string
    //
    static func dateToString(date: Date = Date()) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: date)
    }
}
