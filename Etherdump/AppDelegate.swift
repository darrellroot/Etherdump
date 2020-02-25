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
    
    
    @objc func exportPcap(_ sender: Any) {
        // this is a fake export pcap needed for menu onCommand to work.  But this will be called if no responding ContentView in focus
        debugPrint("exportPcap 2")
    }
    
    var helpWindows: [NSWindow] = [] // memory leak
    var logWindows: [NSWindow] = [] // memory leak but i keep crashing otherwise
    
    var windows: [NSWindow] = [] {
        didSet {
            print("windows.count \(windows.count)")
        }
    }
    var windowCount = 0
    var authorizedUrls: [URL] = []
    var openPanel: NSOpenPanel?
    var appSettings = AppSettings()
    //var fontStyle: Font = .body
    //var fontManager: NSFontManager!

    //Some font menu items only enabled if this is in appdelegate
    @objc public func changeFont(_ sender: AnyObject) {
        appSettings.changeFont(sender)
    }
    
    
    @IBAction func showHelp(_ sender: Any) {
        let helpView = HelpView().environmentObject(appSettings)
        let window = NSWindow(
            contentRect: NSRect(x: 100, y: 100, width: 1000, height: 1000),
            styleMask: [.titled, .closable, .miniaturizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.contentView = NSHostingView(rootView: helpView)
        windowCount = windowCount + 1
        window.title = "\(BuildConfiguration.appName) Help"
        window.tabbingMode = .disallowed
        window.center()
        window.setFrameAutosaveName("Help Window \(windowCount)")
        helpWindows.append(window)
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
        let verboseLogging = true
        LoggingSystem.bootstrap(DarrellLogHandler.bootstrap)
        if verboseLogging {
            Pcapng.logger.logLevel = .info
            EtherCapture.logger.logLevel = .info
        } else {
            Pcapng.logger.logLevel = .error
            EtherCapture.logger.logLevel = .error
        }

        
        if BuildConfiguration.heavy {
            // Create the SwiftUI view that provides the window contents.
            //let contentView = ContentView(showCapture: true, appSettings: appSettings)
            let contentView = ContentView(showCapture: true).environmentObject(appSettings)

            // Create the window and set the content view.
            let window = NSWindow(
                contentRect: NSRect(x: 100, y: 100, width: 1000, height: 1000),
                styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
                backing: .buffered, defer: false)
            //self.windows.append(window)
            window.center()
            window.tabbingMode = .disallowed
            windowCount = windowCount + 1
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
            // Create the SwiftUI view that provides the window contents.
            //let contentView = ContentView(showCapture: true, appSettings: appSettings)
            let contentView = ContentView(showCapture: true).environmentObject(appSettings)

            // Create the window and set the content view.
            let window = NSWindow(
                contentRect: NSRect(x: 100, y: 100, width: 1000, height: 1000),
                styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
                backing: .buffered, defer: false)
            //self.windows.append(window)
            windowCount = windowCount + 1
            window.title = "Capture \(self.windowCount)"
            window.tabbingMode = .disallowed
            window.center()
            //window.setFrameAutosaveName("Window \(self.windowCount)")
            window.contentView = NSHostingView(rootView: contentView)
            window.makeKeyAndOrderFront(nil)
        }
    }

    @IBAction func showLogs(_ sender: NSMenuItem) {
        let logView = LogView().environmentObject(appSettings)
        let window = NSWindow(
            contentRect: NSRect(x: 300, y: 150, width: 1000, height: 1000),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        self.logWindows.append(window)
        window.center()
        window.title = "Logs"
        //window.setFrameAutosaveName("Log Window")
        window.tabbingMode = .disallowed
        window.contentView = NSHostingView(rootView: logView)
        window.makeKeyAndOrderFront(nil)
    }
    
    func exportPcap(frames: [Frame]) {
        debugPrint("appdelegate exportPcap")
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
                    let alertView = AlertView(textMessage: "Unable to save pcap file: \(error)")
                    let window = NSWindow(
                        contentRect: NSRect(x: 50, y: 50, width: 50, height: 50),
                        styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
                        backing: .buffered, defer: false)
                    //self.windows.append(window)
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
                        print("Unable to decode pcap file")
                        let alertView = AlertView(textMessage: "Unable to decode pcap file")
                        let window = NSWindow(
                            contentRect: NSRect(x: 50, y: 50, width: 50, height: 50),
                            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
                            backing: .buffered, defer: false)
                        //self.windows.append(window)
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

