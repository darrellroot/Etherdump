//
//  AppDelegate.swift
//  Etherdump
//
//  Created by Darrell Root on 1/30/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import Cocoa
import SwiftUI
import PackageSwiftPcapng
import PackageEtherCapture
import Logging

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var windows: [NSWindow] = []
    var windowCount = 1
    var authorizedUrls: [URL] = []
    var openPanel: NSOpenPanel?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        let verboseLogging = true
        LoggingSystem.bootstrap(DarrellLogHandler.init)
        if verboseLogging {
            Pcapng.logger.logLevel = .info
            EtherCapture.logger.logLevel = .info
        } else {
            Pcapng.logger.logLevel = .error
            EtherCapture.logger.logLevel = .error
        }

        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()
        
        // Create the window and set the content view. 
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        self.windows.append(window)
        window.center()
        window.setFrameAutosaveName("Window \(self.windowCount)")
        self.windowCount += 1
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @IBAction func authorizePacketCapture(_ sender: NSMenuItem) {
        let openPanel = NSOpenPanel()
        openPanel.directoryURL = URL(fileURLWithPath: "/dev", isDirectory: true)
        self.openPanel = openPanel
        openPanel.allowsMultipleSelection = true
        openPanel.showsHiddenFiles = true
        openPanel.canSelectHiddenExtension = true
        openPanel.canChooseDirectories = false
        openPanel.canChooseFiles = true
        openPanel.begin { (result) -> Void in
            if result.rawValue == NSApplication.ModalResponse.OK.rawValue {
                let urls = openPanel.urls
                self.authorizedUrls.append(contentsOf: urls)
            }
        }
    }
    @IBAction func importPcapngFile(_ sender: NSMenuItem) {
        let panel = NSOpenPanel()
        panel.nameFieldLabel = "Choose a pcapng file to open"
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        panel.canChooseFiles = true
        panel.begin { response in
            if response == NSApplication.ModalResponse.OK, let url = panel.url {
                debugPrint("opening url \(url)")
                let result = Result {
                    try Data(contentsOf: url)
                }
                switch result {
                case .failure(let error):
                    debugPrint("open file failed with error \(error)")
                    return
                case .success(let data):
                    let pcapng = Pcapng(data: data)
                    guard let packetBlocks = pcapng?.segments.first?.packetBlocks else {
                        debugPrint("Error: unable to get packets from decoding PCAPNG file \(url)")
                        return
                    }
                    var frames: [Frame] = []
                    for (count,packet) in packetBlocks.enumerated() {
                        let frame = Frame(data: packet.packetData)
                        frames.append(frame)
                    }
                    let contentView = ContentView(frames: frames)
                    let window = NSWindow(
                        contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
                        styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
                        backing: .buffered, defer: false)
                    self.windows.append(window)
                    window.center()
                    window.setFrameAutosaveName("Window \(self.windowCount)")
                    self.windowCount += 1
                    window.contentView = NSHostingView(rootView: contentView)
                    window.makeKeyAndOrderFront(nil)
                    self.windows.append(window)
                    return
                }
            }
        }
    }
    
}

