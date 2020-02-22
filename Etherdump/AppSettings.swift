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
    let fontManager = NSFontManager.shared

    var fontStyle: Font.TextStyle = .body
    
    init() {
        if let newFont = NSFont(name: "Courier", size: 12) {
            fontManager.setSelectedFont(newFont, isMultiple: false)
            self.nsfont = newFont
        } else {
            debugPrint("Warning failed to initialize Courier font")
            self.nsfont = NSFont.systemFont(ofSize: 12)
        }
        self.font = Font(self.nsfont)
        //font = Font.system(fontStyle, design: .monospaced)
        fontManager.setSelectedFont(self.nsfont, isMultiple: false)
        fontManager.target = self
        fontManager.action = #selector(self.changeFont(sender:))
        fontManager.isEnabled = true
    }
    @objc public func changeFont(sender: AnyObject) {
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
