//
//  AppSettings.swift
//  Etherdump
//
//  Created by Darrell Root on 2/16/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import Foundation
import SwiftUI
import Network

class AppSettings: ObservableObject {
    @Published var font: Font
    @Published var interfaces: [String]
    let monitor: NWPathMonitor
    var bodyFontSize = 17 {
        didSet {
            self.font = Font.system(size: CGFloat(bodyFontSize), weight: .regular, design: .monospaced)
        }
    }
    var fontStyle: Font.TextStyle = .body
    
    init() {
        //self.font = Font.system(.body, design: .monospaced)
        self.font = Font.system(size: CGFloat(bodyFontSize), weight: .regular, design: .monospaced)
        self.monitor = NWPathMonitor()
        self.interfaces = []
        monitor.pathUpdateHandler = { path in
            var interfaces: [String] = []
            for nwInterface in path.availableInterfaces {
                interfaces.append(nwInterface.debugDescription)
            }
            self.interfaces = interfaces
        }
        monitor.start(queue: .main)
        
    }
    func biggerFont(_ sender: NSMenuItem) {
        self.bodyFontSize += 2
    }
    func defaultFont(_ sender: NSMenuItem) {
        self.bodyFontSize = 17
    }
    func smallerFont(_ sender: NSMenuItem) {
        self.bodyFontSize -= 2
    }

}
