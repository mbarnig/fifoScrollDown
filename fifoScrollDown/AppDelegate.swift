//
//  AppDelegate.swift
//  fifoScrollDown
//
//  Created by Marco Barnig on 10/11/2016.
//  Copyright © 2016 Marco Barnig. All rights reserved.
//

import Cocoa

// protocol

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
}  // end class

