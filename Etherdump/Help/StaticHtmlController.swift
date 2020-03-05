//
//  StaticHTMLController.swift
//  Network Mom
//
//  Created by Darrell Root on 12/2/18.
//  Copyright © 2018 Darrell Root LLC. All rights reserved.
//

import Cocoa
import WebKit

class StaticHtmlController: NSWindowController {

    @IBOutlet weak var webViewOutlet: WKWebView!

    var resource: String! //Caller must set this before showing window
    
    override var windowNibName: NSNib.Name? {
        return NSNib.Name("StaticHtmlController")
    }

    override func windowDidLoad() {
        super.windowDidLoad()
        let html: String = loadHTML()
        webViewOutlet.loadHTMLString(html, baseURL: nil)
    }
    func loadHTML() -> String {
        var html: String
        guard let resource = resource else {
            return("Error: no resource file specified")
        }
        window?.title = resource.capitalized
        guard let filePath = Bundle.main.path(forResource: resource, ofType:"html") else {
            return("Error reading \(resource).html file")
        }
        let url = URL(fileURLWithPath: filePath)
        do {
            html = try String(contentsOf: url, encoding: .utf8)
        }
        catch {
            return("Error reading \(resource).html file")
        }
        return(html)
    }
}
