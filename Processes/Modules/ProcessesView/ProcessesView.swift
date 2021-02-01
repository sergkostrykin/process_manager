//
//  BatteryStatusView.swift
//  MacBattery
//
//  Created by Sergiy Kostrykin on 8/14/19.
//  Copyright © 2019 Tweakbit. All rights reserved.
//

import Cocoa
import MBPopup

class ProcessesView: NSView {

    // MARK: - Properties
    private let powerValuesCountMax: Int = 20
    private var popupController: MBPopupController!
    private var processes = [AppProcess]()
    private let queue = OperationQueue()
    
    // MARK: - Outlets
    @IBOutlet weak var backgroundViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var backgroundView: NSView!
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var infoContainerView: NSView!
    @IBOutlet weak var topContainerView: NSView!
    @IBOutlet weak var topContainerViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    
    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        _ = AppRouter.shared
        setupPopup()
        setupUI()
        startProcessesTracking()
        DistributedNotificationCenter.default.addObserver(self, selector: #selector(interfaceModeChanged(sender:)), name: NSNotification.Name(rawValue: "AppleInterfaceThemeChangedNotification"), object: nil)
    }
    
    override func viewWillDraw() {
        super.viewWillDraw()
    }
    
    override func viewDidUnhide() {
        super.viewDidUnhide()
    }
    
    override func viewDidHide() {
        super.viewDidHide()
    }
}

// MARK: - Private methods
private extension ProcessesView {
    
    func setupPopup() {
        popupController = MBPopupController(contentView: self)
        popupController.backgroundView.backgroundColor =  NSColor.black.withAlphaComponent(0.5)//.clear
        popupController.willOpenPopup = { [weak self] (keys) in
        }
        popupController.statusItem.image = NSImage(named: "status_bar_icon")
        popupController.statusItem.highlightMode = false
        updateStatusBarIcon()
     }

    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.selectionHighlightStyle = .none
        backgroundView.wantsLayer = true
        backgroundView.layer?.cornerRadius = 5
        progressIndicator.startAnimation(nil)
    }
    
    func updateStatusBarIcon() {
        popupController.statusItem.attributedTitle = nil
    }
    
    func startProcessesTracking() {
        let operation = ProcessesService { [weak self] processes in
            DispatchQueue.main.async { [weak self] in
                self?.progressIndicator.stopAnimation(nil)
                self?.progressIndicator.isHidden = true
                self?.processes = processes
                self?.tableView.reloadData()
            }
        }
        queue.addOperation(operation)
    }
        
    func showPopover(text: String, anchorView: NSView?) {
        let popover = Popover(text: text, anchor: anchorView)
        popover.show()
    }

    @objc func interfaceModeChanged(sender: NSNotification) {
        updateStatusBarIcon()
    }

}

// MARK: - NSTableViewDataSource
extension ProcessesView: NSTableViewDataSource, NSTableViewDelegate {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return processes.count
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let process = processes[row]
        let view = TextSectionView.createFromNib()
        view.setup(title: process.name,
                   image: NSRunningApplication(processIdentifier: process.pid)?.icon,
                   size: process.size.formattedFileSize,
                   user: process.user) { [weak self] in
            process.terminate()
            self?.processes.remove(at: row)
            tableView.reloadData()
        }
        return view
    }
}
