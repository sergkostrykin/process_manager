//
//  NibLoadable.swift
//  Processes
//
//  Created by Sergiy Kostrykin on 31.01.2021.
//

import Cocoa

protocol NibLoadable {
    // Name of the nib file
    static var nibName: String { get }
    static func createFromNib(in bundle: Bundle) -> Self
}

extension NibLoadable where Self: NSView {
    
    // Default nib name must be same as class name
    static var nibName: String {
        return String(describing: Self.self)
    }
    
    static func createFromNib(in bundle: Bundle = Bundle.main) -> Self {
        var topLevelArray: NSArray? = nil
        bundle.loadNibNamed(NSNib.Name(nibName), owner: self, topLevelObjects: &topLevelArray)
        let views = Array<Any>(topLevelArray!).filter { $0 is Self }
        return views.last as! Self
    }
    
    static func createFromNib(in bundle: Bundle = Bundle.main, superview: NSView) -> Self {
        let view = createFromNib(in: bundle)
        superview.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: superview.topAnchor, constant: 0),
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 0),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 0),
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 0)
            ])
        return view
    }

}
