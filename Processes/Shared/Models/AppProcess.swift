//
//  AppProcess.swift
//  Processes
//
//  Created by Sergiy Kostrykin on 31.01.2021.
//

import Cocoa

struct AppProcess: Codable, Equatable {
    
    let name: String
    let pid: pid_t
    let size: UInt64
    let user: String
    
    static func == (lhs: AppProcess, rhs: AppProcess) -> Bool {
        return lhs.pid == rhs.pid
    }
    
    var isRoot: Bool {
        return user == "root" || user.hasPrefix("_")
    }
    
    func terminate() {
        if let application = NSRunningApplication(processIdentifier: pid) {
            application.terminate()
        } else {
            kill(pid, SIGCONT)
        }
    }
}
