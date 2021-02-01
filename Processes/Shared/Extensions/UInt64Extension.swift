//
//  UInt64Extension.swift
//  Processes
//
//  Created by Sergiy Kostrykin on 01.02.2021.
//

import Foundation

extension UInt64 {
    var formattedFileSize: String {
        return Format.stringFrom(bytes: self)
    }
    
    var formattedFileSizePlain: String {
        return Format.stringFrom(bytes: self, digits: 0)
    }
}
