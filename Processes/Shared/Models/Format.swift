//
//  Format.swift
//  Processes
//
//  Created by Sergiy Kostrykin on 01.02.2021.
//

import Foundation

final class Format {
    
    private static let units = [
        "KB",
        "MB",
        "GB"
    ]
    
    static func stringFrom(bytes: UInt64, digits: Int = 1) -> String {
        let bps: Double = 1024
        if bytes < UInt64(bps) {
            return "\(bytes) B"
        }
        let exp = Int(log2(Double(bytes)) / log2(bps))
        let unit = units[exp - 1]
        let number = Double(bytes) / pow(bps, Double(exp))
        return String(format: "%.\(digits)f %@", number, unit)
    }
    
}
