//
//  PopoverView.swift
//  Processes
//
//  Created by Sergiy Kostrykin on 31.01.2021.
//
//

import Cocoa

final class Popover: NSPopover, NSPopoverDelegate {
    
    private var anchorView: NSView?
    private var text: String?

    init(text: String, anchor view: NSView? = nil) {
        super.init()
        self.text = text
        behavior = .transient
        animates = true
        delegate = self
        anchorView = view
        appearance = NSAppearance(named: NSAppearance.Name.vibrantLight)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    func show(anchor view: NSView? = nil, preferredEdge: NSRectEdge = .maxY) {
        guard view != nil || anchorView != nil else {
            fatalError("Anchor view must be specified.")
        }
        if isShown {
            close()
        }
        let controller = NSViewController()
        let contentView = PopoverMain(frame: .zero)
        contentView.wantsLayer = true
        controller.view = contentView
        contentViewController = controller
        let popoverTextView = PopoverTextView.createFromNib(superview: contentView)
        popoverTextView.setup(text: text ?? "")
        let v = view ?? anchorView!
        show(relativeTo: v.bounds, of: v, preferredEdge: preferredEdge)
    }
    
    func popoverShouldClose(_ popover: NSPopover) -> Bool {
        return true
    }
}

class PopoverMain: NSView{
    override func viewDidMoveToWindow() {
        guard let frameView = window?.contentView?.superview else { return }
        
        let backgroundView = PopoverMainView(frame: frameView.bounds)
        backgroundView.autoresizingMask = [.width, .height]
        frameView.addSubview(backgroundView, positioned: .below, relativeTo: frameView)
    }
}

class PopoverMainView: NSView {
    override func draw(_ dirtyRect: NSRect) {
        NSColor.gray.set()
        self.bounds.fill()
    }
}
