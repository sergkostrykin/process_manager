//
//  StringExtension.swift
//  Processes
//
//  Created by Sergiy Kostrykin on 31.01.2021.
//

import Cocoa

extension String {
    
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    
    var ramSize: UInt64 {
        guard let amount = UInt64(self.digits) else { return 0 }
        var multiplyer: UInt64 = 1
        if self.contains("M") {
            multiplyer = 1024 * 1024
        } else if self.contains("K") {
            multiplyer = 1024
        } else if self.contains("G") {
            multiplyer = 1024 * 1024 * 1024
        }
        return amount * multiplyer
    }
    
    func index(substring: String) -> Int? {
        guard let range = self.range(of: substring) else { return nil }
        return self.distance(from: self.startIndex, to: range.lowerBound)
    }
    
    func appending(path: String) -> String {
        let nsSt = self as NSString
        return nsSt.appendingPathComponent(path)
    }
    
    
    func getEmails() -> [String] {
        if let regex = try? NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}", options: .caseInsensitive) {
            let string = self as NSString
            return regex.matches(in: self, options: [], range: NSRange(location: 0, length: string.length)).map {
                string.substring(with: $0.range).replacingOccurrences(of: "", with: "").lowercased()
            }
        }
        return []
    }
    
    func cropped(after separator: String) -> String {
        guard let string = self.components(separatedBy: separator).first else { return self }
        return string + separator
    }
    
    var attributed: NSMutableAttributedString {
        return NSMutableAttributedString(string: self)
    }
    
}

extension String {
    
    subscript (indexCharacter: Int) -> Character {
        return self[index(startIndex, offsetBy: indexCharacter)]
    }
    
    subscript (indexCharacter: Int) -> String {
        return String(self[indexCharacter] as Character)
    }
    //
    //    subscript (range: Range<Int>) -> String {
    //        let start = index(startIndex, offsetBy: range.lowerBound)
    //        let end = index(startIndex, offsetBy: range.upperBound)
    //        let range = Range(start ..< end)
    //        return String(self[])
    //    }
}

extension String {
    
    func trimmed() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var keepNumericsOnly: String {
        return self.components(separatedBy: CharacterSet(charactersIn: "0123456789").inverted).joined(separator: "")
    }
    
}

extension String {
    static func macSerialNumber() -> String {
        let platformExpert: io_service_t = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IOPlatformExpertDevice"))
        let serialNumberAsCFString = IORegistryEntryCreateCFProperty(platformExpert, kIOPlatformSerialNumberKey as CFString, kCFAllocatorDefault, 0)
        IOObjectRelease(platformExpert)
        return (serialNumberAsCFString?.takeUnretainedValue() as? String) ?? ""
    }
}

extension String {
    
    subscript(value: NSRange) -> Substring {
        return self[value.lowerBound..<value.upperBound]
    }
    
    subscript(value: CountableClosedRange<Int>) -> Substring {
        return self[index(at: value.lowerBound)...index(at: value.upperBound)]
    }
    
    subscript(value: CountableRange<Int>) -> Substring {
        return self[index(at: value.lowerBound)..<index(at: value.upperBound)]
    }
    
    subscript(value: PartialRangeUpTo<Int>) -> Substring {
        return self[..<index(at: value.upperBound)]
    }
    
    subscript(value: PartialRangeThrough<Int>) -> Substring {
        return self[...index(at: value.upperBound)]
    }
    
    subscript(value: PartialRangeFrom<Int>) -> Substring {
        return self[index(at: value.lowerBound)...]
    }
    
    func index(at offset: Int) -> String.Index {
        return index(startIndex, offsetBy: offset)
    }
    
}

extension String {
    
    var ns: NSString {
        return self as NSString
    }
        
    var pathExtension: String {
        return ns.pathExtension
    }
    
    var lastPathComponent: String {
        return ns.lastPathComponent
    }
    
    var stringByDeletingPathExtension: String {
        return ns.deletingPathExtension
    }
    
    func stringByAppendingPathComponent(_ component: String) -> String {
        return ns.appendingPathComponent(component)
    }

    func stringByAppendingPathExtension(_ component: String) -> String {
        return ns.appendingPathExtension(component) ?? self
    }
}
