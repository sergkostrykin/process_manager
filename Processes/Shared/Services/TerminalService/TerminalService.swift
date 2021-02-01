//
//  TerminalService.swift
//  Processes
//
//  Created by Sergiy Kostrykin on 31.01.2021.
//

import Foundation

class TerminalService {
    
//    private static let doShellScript: String = "do shell script "
//    private static let withAdministrator: String = " with administrator privileges"
//    
//    @discardableResult
//    static func runScript(named: String, sudo: Bool = false) -> (error: [String]?, exitCode: Int32) {
//        if let path = Bundle.main.path(forResource: named, ofType: "sh") {
//            let result = runCommand(cmd: "/bin/sh", args: path)
//            return (error: result.error.count > 0 ? result.error : nil, result.exitCode)
//        }
//        return (nil, -1)
//    }

    @discardableResult
    class func runCommand(cmd: String, args: String...) -> (output: [String], error: [String], exitCode: Int32) {
        var output: [String] = []
        var error: [String] = []

        let task = Process()
        task.launchPath = cmd
        task.arguments = args

        let outpipe = Pipe()
        task.standardOutput = outpipe
        let errpipe = Pipe()
        task.standardError = errpipe

        task.launch()

        let outdata = outpipe.fileHandleForReading.readDataToEndOfFile()
        if var string = String(data: outdata, encoding: .utf8) {
            string = string.trimmingCharacters(in: .newlines)
            output = string.components(separatedBy: "\n")
        }

        let errdata = errpipe.fileHandleForReading.readDataToEndOfFile()
        if var string = String(data: errdata, encoding: .utf8) {
            string = string.trimmingCharacters(in: .newlines)
            error = string.components(separatedBy: "\n")
        }

        task.waitUntilExit()
        let status = task.terminationStatus

        return (output, error, status)
    }
}
