//
//  AppDelegate.swift
//  PDFGeneratorTableView
//
//  Created by thierryH24 on 02/09/2018.
//  Copyright © 2018 thierryH24. All rights reserved.
//

import AppKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    var mainWindowController: MainWindowController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        initializeMainWindow()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func initializeMainWindow() {
        
        mainWindowController = MainWindowController()
        mainWindowController?.showWindow(self)
    }
    
    func applicationShouldTerminateAfterLastWindowClosed (_ sender: NSApplication) -> Bool
    {
        return true
    }
    
}

