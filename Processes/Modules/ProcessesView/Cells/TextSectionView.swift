//
//  TextSectionView.swift
//  MacBattery
//
//  Created by Sergiy Kostrykin on 9/4/19.
//  Copyright © 2019 Tweakbit. All rights reserved.
//

import Cocoa

class TextSectionView: NSView, NibLoadable {
    
    // MARK: - Properties
    private var onClose: (()->())?
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var valueLabel: NSTextField!
    @IBOutlet weak var sizeLabel: NSTextField!
    @IBOutlet weak var imageContainerViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var processImageView: NSImageView!
    
    // MARK: - Actions
    @IBAction func closeButtonClicked(_ sender: Any) {
        onClose?()
    }
    
    // MARK: - Methods
    func setup(title: String, image: NSImage?, size: String, user: String, onClose: (()->())?) {
        self.onClose = onClose
        titleLabel.stringValue = title
        sizeLabel.stringValue = size
        valueLabel.stringValue = user
        processImageView.image = image
        imageContainerViewConstraint.constant = image == nil ? 0 : 20
    }
}
