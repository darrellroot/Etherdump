//
//  AppSettings.swift
//  Etherdump
//
//  Created by Darrell Root on 2/16/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import Foundation
import SwiftUI

class AppSettings: ObservableObject {
    @Published var font: Font
    var nsfont: NSFont
    var fontManager: NSFontManager!

    var fontStyle: Font.TextStyle = .body
    
    init() {

        self.fontManager = NSFontManager.shared
        if let newFont = NSFont(name: "Courier", size: 12) {
            fontManager.setSelectedFont(newFont, isMultiple: false)
            self.nsfont = newFont
        } else {
            debugPrint("Warning failed to initialize San Francisco font")
            self.nsfont = NSFont.systemFont(ofSize: 12)
        }
        //self.font = Font.system(.body, design: .monospaced)
        self.font = Font.system(size: 17, weight: .regular, design: .monospaced)
        
        fontManager.target = self
        fontManager.setSelectedFont(self.nsfont, isMultiple: false)
    }
    @objc public func changeFont(_ sender: AnyObject) {
        debugPrint("font changed")
        guard let sender = sender as? NSFontManager else {
            return
        }
        let selectedFont = sender.convert(nsfont)
        debugPrint("selected font \(selectedFont)")
        self.font = Font(selectedFont)
        self.nsfont = selectedFont
    }

}
