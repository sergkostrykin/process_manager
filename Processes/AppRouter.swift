//
//  AppRouter.swift
//  Processes
//
//  Created by Sergiy Kostrykin on 31.01.2021.
//

import Cocoa
import MBPopup
import Sparkle

final class AppRouter {
    
    static let shared = AppRouter()
    private var popupController: MBPopupController?

    init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(windowWillClose),
                                               name: NSWindow.willCloseNotification,
                                               object: nil)
    }
    
    func openSettings(popupController: MBPopupController?) {
//        self.popupController = popupController
//        let menu = SettingsMenu()
//        menu.show()
    }
    

    
    func checkForUpdates() {
        SUUpdater.shared()?.checkForUpdates(popupController)
    }
}

private extension AppRouter {
    
    @objc func windowWillClose(_ notification: Notification) {
    }

}
