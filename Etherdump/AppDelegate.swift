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
        LoggingSystem.bootstrap(DarrellLogHandler.bootstrap)
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
    
    @IBAction func showLogs(_ sender: NSMenuItem) {
        let logView = LogView()
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 3000, height: 400),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        self.windows.append(window)
        window.center()
        window.setFrameAutosaveName("Window \(self.windowCount)")
        self.windowCount += 1
        window.contentView = NSHostingView(rootView: logView)
        window.makeKeyAndOrderFront(nil)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @IBAction func importPcapngFile(_ sender: NSMenuItem) {
        let panel = NSOpenPanel()
        panel.nameFieldLabel = "Choose a pcap or pcapng file to open"
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
                    switch PcapType.detect(data: data) {
                    case .pcap:
                        let pcap = try Pcap(data: data)
                        for (count,packet) in pcap.packets.enumerated() {
                            let frame = Frame(data: packet.packetData)
                            displayFrame(frame: frame, packetCount: Int32(count), arguments: arguments)
                        }
                    case .pcapng:
                        let pcapng = Pcapng(data: data)
                        var packetBlocks: [PcapngPacket] = []
                        for segment in pcapng?.segments ?? [] {
                            packetBlocks.append(contentsOf: segment.packetBlocks)
                        }
                        for (count,packet) in packetBlocks.enumerated() {
                            let frame = Frame(data: packet.packetData)
                            displayFrame(frame: frame, packetCount: Int32(count), arguments: arguments)
                        }
                    case .neither:
                        print("Unable to decode pcap file")
                        exit(EXIT_FAILURE)

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

