//
//  Usage.swift
//  WooodStressTests
//
//  Created by Vaibhav Singh on 22/05/18.
//  Copyright © 2018 Vaibhav. All rights reserved.
//

import Foundation

class ConsoleIO {

    enum OutputType {
        case error
        case standard
    }

    func writeMessage(_ message: String, to: OutputType = .standard) {
        switch to {
        case .standard:
            print("\(message)")
        case .error:
            fputs("Error: \(message)\n", stderr)
        }
    }

    func printUsage() {

        let executableName = (CommandLine.arguments[0] as NSString).lastPathComponent

        writeMessage("usage:")
        writeMessage("\(executableName) -a number_of_users(Interger) time_b/w_users(milliseconds) time_b/w_api_calls(milliseconds)")
        writeMessage("\(executableName) -h to show usage information")
        writeMessage("Type \(executableName) without an option to enter default mode.")
    }
}
