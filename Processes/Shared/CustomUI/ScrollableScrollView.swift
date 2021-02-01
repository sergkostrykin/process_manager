//
//  ScrollableScrollView.swift
//  Processes
//
//  Created by Sergiy Kostrykin on 31.01.2021.
//

import Cocoa

class ScrollableScrollView: NSScrollView {
    
    var isScrollingEnabled: Bool = true
    
    override func scrollWheel(with event: NSEvent) {
        if isScrollingEnabled {
            super.scrollWheel(with: event)
        }
    }
}
