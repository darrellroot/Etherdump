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
    
    @IBOutlet weak var etherdumpLiteMenuItem: NSMenuItem!
    @IBOutlet weak var aboutEtherdumpLiteMenuItem: NSMenuItem!
    @IBOutlet weak var newCaptureWindowMenuItem: NSMenuItem!
    @IBOutlet weak var etherdumpLiteHelpMenuItem: NSMenuItem!
    
    
    @IBAction @objc func exportAllPcap(_ sender: Any) {
        // this is a fake export pcap needed for menu onCommand to work.  But this will be called if no responding ContentView in focus
        debugPrint("exportAllPcap AppDelegate")
    }
    @IBAction @objc func exportFilteredPcap(_ sender: Any) {
        // this is a fake export pcap needed for menu onCommand to work.  But this will be called if no responding ContentView in focus
        debugPrint("exportFilteredPcap AppDelegate")
    }

    var windows: [Int:NSWindow] = [:]
    
    var windowCount = 0
    var authorizedUrls: [URL] = []
    var openPanel: NSOpenPanel?
    var appSettings = AppSettings()
    
    @IBAction func biggerFont(_ sender: NSMenuItem) {
        appSettings.biggerFont(sender)
    }
    
    @IBAction func defaultFont(_ sender: NSMenuItem) {
        appSettings.defaultFont(sender)
    }
    
    @IBAction func smallerFont(_ sender: NSMenuItem) {
        appSettings.smallerFont(sender)
    }
    
    @IBAction func showHelp(_ sender: Any) {
        windowCount = windowCount + 1
        let helpView = HelpView().environmentObject(appSettings)
        let window = NSWindow(
            contentRect: NSRect(x: 100, y: 100, width: 1000, height: 1000),
            styleMask: [.titled, .closable, .miniaturizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.isReleasedWhenClosed = false
        window.contentView = NSHostingView(rootView: helpView)
        window.title = "\(BuildConfiguration.appName) Help"
        window.tabbingMode = .disallowed
        window.center()
        window.setFrameAutosaveName("Help Window \(windowCount)")
        windows[windowCount] = window
        window.makeKeyAndOrderFront(nil)
    }
    
    @IBAction func showAbout(_ sender: Any) {
        windowCount = windowCount + 1
        let aboutView = AboutView().environmentObject(appSettings)
        let window = NSWindow(
            contentRect: NSRect(x: 100, y: 100, width: 1000, height: 1000),
            styleMask: [.titled, .closable, .miniaturizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.isReleasedWhenClosed = false
        window.contentView = NSHostingView(rootView: aboutView)
        window.title = "About \(BuildConfiguration.appName)"
        window.tabbingMode = .disallowed
        window.center()
        window.setFrameAutosaveName("About Window \(windowCount)")
        windows[windowCount] = window
        window.makeKeyAndOrderFront(nil)
    }

    
    
    func setupFullVersion() {
        etherdumpLiteMenuItem.title = "Etherdump"
        aboutEtherdumpLiteMenuItem.title = "About Etherdump"
        newCaptureWindowMenuItem.isEnabled = true
        etherdumpLiteHelpMenuItem.title = "Etherdump Help"
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        if BuildConfiguration.heavy {
            setupFullVersion()
        }
        let verboseLogging = false
        LoggingSystem.bootstrap(DarrellLogHandler.bootstrap)
        if verboseLogging {
            Pcapng.logger.logLevel = .info
            EtherCapture.logger.logLevel = .info
            DarrellLogHandler.logger.logLevel = .info
        } else {
            Pcapng.logger.logLevel = .error
            EtherCapture.logger.logLevel = .error
            DarrellLogHandler.logger.logLevel = .error
        }

        
        if BuildConfiguration.heavy {
            windowCount = windowCount + 1
            let contentView = ContentView(showCapture: true).environmentObject(appSettings)

            let window = NSWindow(
                contentRect: NSRect(x: 100, y: 100, width: 1000, height: 1000),
                styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
                backing: .buffered, defer: false)
            window.isReleasedWhenClosed = false
            windows[windowCount] = window
            window.center()
            window.tabbingMode = .disallowed
            window.title = "Capture \(self.windowCount)"
            //window.setFrameAutosaveName("Window \(self.windowCount)")
            window.contentView = NSHostingView(rootView: contentView)
            window.makeKeyAndOrderFront(nil)
        }
    }
    
    @IBAction func newCaptureWindow(_ sender: Any) {
        self.newCaptureWindow()
    }
    func newCaptureWindow() {
        if BuildConfiguration.heavy {
            windowCount = windowCount + 1
            let contentView = ContentView(showCapture: true).environmentObject(appSettings)
            let window = NSWindow(
                contentRect: NSRect(x: 100, y: 100, width: 1000, height: 1000),
                styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
                backing: .buffered, defer: false)
            window.isReleasedWhenClosed = false
            windows[windowCount] = window
            window.title = "Capture \(self.windowCount)"
            window.tabbingMode = .disallowed
            window.center()
            //window.setFrameAutosaveName("Window \(self.windowCount)")
            window.contentView = NSHostingView(rootView: contentView)
            window.makeKeyAndOrderFront(nil)
        }
    }

    @IBAction func showLogs(_ sender: NSMenuItem) {
        windowCount = windowCount + 1
        let logView = LogView().environmentObject(appSettings)
        let window = NSWindow(
            contentRect: NSRect(x: 300, y: 150, width: 1000, height: 1000),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.isReleasedWhenClosed = false
        windows[windowCount] = window
        window.center()
        window.title = "Logs"
        //window.setFrameAutosaveName("Log Window")
        window.tabbingMode = .disallowed
        window.contentView = NSHostingView(rootView: logView)
        window.makeKeyAndOrderFront(nil)
    }
    
    func exportPcap(frames: [Frame]) {
        debugPrint("appdelegate exportPcap \(frames.count) frames")
        guard frames.count > 0 else {
            return
        }
        let pcapData = EtherCapture.makePcap(frames: frames)
        let panel = NSSavePanel()
        panel.title = "PCAP Export \(frames.count) Frames"
        panel.nameFieldLabel = "Filename:"
        panel.prompt = "Export"
        panel.allowedFileTypes = ["pcap"]
        panel.allowsOtherFileTypes = true
        panel.begin { response in
            if response == NSApplication.ModalResponse.OK, let url = panel.url {
                debugPrint("saving url \(url)")
                do {
                    try pcapData.write(to: url)
                } catch {
                    self.windowCount += 1
                    let alertView = AlertView(textMessage: "Unable to save pcap file: \(error)")
                    let window = NSWindow(
                        contentRect: NSRect(x: 50, y: 50, width: 50, height: 50),
                        styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
                        backing: .buffered, defer: false)
                    //self.windows.append(window)
                    self.windows[self.windowCount] = window
                    window.center()
                    //window.setFrameAutosaveName("Window \(self.windowCount)")
                    window.contentView = NSHostingView(rootView: alertView)
                    window.makeKeyAndOrderFront(nil)

                }
            }
        }
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
                    var frames: [Frame] = []

                    switch PcapType.detect(data: data) {
                    case .pcap:
                        guard let pcap = try? Pcap(data: data) else {
                            debugPrint("Unable to decode pcap file")
                            return
                        }
                        for (count,packet) in pcap.packets.enumerated() {
                            let frame = Frame(data: packet.packetData, originalLength: packet.originalLength)
                            frames.append(frame)
                        }
                    case .pcapng:
                        let pcapng = Pcapng(data: data)
                        var packetBlocks: [PcapngPacket] = []
                        for segment in pcapng?.segments ?? [] {
                            packetBlocks.append(contentsOf: segment.packetBlocks)
                        }
                        for (count,packet) in packetBlocks.enumerated() {
                            let frame = Frame(data: packet.packetData, originalLength: packet.originalLength)
                            frames.append(frame)
                        }
                    case .neither:
                        self.windowCount += 1
                        DarrellLogHandler.logger.error("Unable to decode pcap file for url \(url)")
                        let alertView = AlertView(textMessage: "Unable to decode pcap file")
                        let window = NSWindow(
                            contentRect: NSRect(x: 50, y: 50, width: 50, height: 50),
                            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
                            backing: .buffered, defer: false)
                        window.isReleasedWhenClosed = false
                        self.windows[self.windowCount] = window
                        window.center()
                        //window.setFrameAutosaveName("Window \(self.windowCount)")
                        window.contentView = NSHostingView(rootView: alertView)
                        window.makeKeyAndOrderFront(nil)
                        return
                    }
                    //let contentView = ContentView(frames: frames, showCapture: false, appSettings: self.appSettings)
                    
                    let contentView = ContentView(frames: frames, showCapture: false).environmentObject(self.appSettings)

                    let window = NSWindow(
                        contentRect: NSRect(x: 100, y: 100, width: 500, height: 500),
                        styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
                        backing: .buffered, defer: false)
                    //self.windows.append(window)
                    window.isReleasedWhenClosed = false
                    window.title = url.lastPathComponent
                    window.center()
                    window.tabbingMode = .disallowed
                    //window.setFrameAutosaveName("Window \(self.windowCount)")
                    window.contentView = NSHostingView(rootView: contentView)
                    window.makeKeyAndOrderFront(nil)
                    return
                }// switch result
            }
        }
    }
    
}

