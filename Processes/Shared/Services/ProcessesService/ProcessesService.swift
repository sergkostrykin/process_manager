//
//  ProcessesService.swift
//  Processes
//
//  Created by Sergiy Kostrykin on 31.01.2021.
//

import Cocoa

class ProcessesService: Operation {
    
    private var processes = [AppProcess]()
    private var onUpdate: (([AppProcess]) -> ())?
    
    init(onUpdate: (([AppProcess]) -> ())?) {
        self.onUpdate = onUpdate
    }
    
    override func main() {
        trackProcesses()
    }


    func trackProcesses() {
        let output = TerminalService.runCommand(cmd: "/usr/bin/top", args: "-l", "1", "-ncols", "30")
        for line in output.output {
            guard !isCancelled else { return }
            let array = line.components(separatedBy: " ").filter({ !$0.isEmpty })
            if array.count > 8,
                let pidString = array.first,
                let pid = pid_t(pidString) {
                let localizedName = NSRunningApplication(processIdentifier: pid)?.localizedName ?? ""
                let processName = !localizedName.isEmpty ? localizedName : array[1]
                var ramSize = array[7].ramSize
                
                if ramSize < 4096 {
                    let processOutput = TerminalService.runCommand(cmd: "/usr/bin/top", args: "-l", "1", "-pid", "\(pid)", "-ncols", "8")
                    ramSize = processOutput.output.last?.components(separatedBy: " ").last?.ramSize ?? 0
                }
                let user = array.last?.components(separatedBy: " ").last ?? ""
                let process = AppProcess(name: processName,
                                            pid: pid,
                                            size: ramSize,
                                            user: user)
                if let index = processes.firstIndex(where: { $0 == process}) {
                    processes.remove(at: index)
                    processes.insert(process, at: index)
                } else {
                    processes.append(process)
                }
                onUpdate?(processes)
            }
        }
        if !isCancelled {
            trackProcesses()
        }
    }
}
