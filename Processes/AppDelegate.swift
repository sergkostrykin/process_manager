//
//  AppDelegate.swift
//  Processes
//
//  Created by Sergiy Kostrykin on 31.01.2021.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var appRouter: AppRouter?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        appRouter = AppRouter.shared
        UserDefaults.standard.register(defaults: ["NSApplicationCrashOnExceptions": true])
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }

}

