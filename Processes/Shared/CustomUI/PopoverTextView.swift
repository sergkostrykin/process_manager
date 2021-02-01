//
//  PopoverTextView.swift
//  MacBattery
//
//  Created by Sergiy Kostrykin on 9/9/19.
//  Copyright © 2019 Tweakbit. All rights reserved.
//

import Cocoa

class PopoverTextView: NSView, NibLoadable {
    
    @IBOutlet weak var textLabel: NSTextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textLabel.maximumNumberOfLines = 5
    }
    
    func setup(text: String) {
        textLabel.stringValue = text
    }
}
