//
//  DisplayFilterView.swift
//  Etherdump
//
//  Created by Darrell Root on 2/7/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI
import PackageEtherCapture
import Network

struct DisplayFilterView: View {
    @Binding var layer2Filter: Layer2Filter
    @Binding var layer3Filter: Layer3Filter
    @Binding var layer4Filter: Layer4Filter
    @Binding var portFilterA: String
    @Binding var portFilterB: String
    @Binding var ipFilterA: String
    @Binding var ipFilterB: String
    @Binding var frames: [Frame]
    var filteredFrames: [Frame]
    let appDelegate = NSApplication.shared.delegate as! AppDelegate

    var validPortFilterA: Bool {
        guard let port = Int(portFilterA) else {
            return false
        }
        guard port >= 0 && port < 65536 else {
            return false
        }
        return true
    }
    var validPortFilterB: Bool {
        guard let port = Int(portFilterB) else {
            return false
        }
        guard port >= 0 && port < 65536 else {
            return false
        }
        return true
    }

    var validIpA: Bool {
        if let _ = IPv4Address(ipFilterA) {
            let dotCount = ipFilterA.filter {$0 == "."}.count
            guard dotCount == 3 else {
                return false
            }
            return true
        }
        if let _ = IPv6Address(ipFilterA) {
            return true
        }
        return false
    }
    var validIpB: Bool {
        if let _ = IPv4Address(ipFilterB) {
            let dotCount = ipFilterB.filter {$0 == "."}.count
            guard dotCount == 3 else {
                return false
            }
            return true
        }
        if let _ = IPv6Address(ipFilterB) {
            return true
        }
        return false
    }

    var body: some View {
        HStack {
            VStack {
                Text("Filter Controls:").fontWeight(.semibold)
                TextField("Port Filter", text: $portFilterA)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                .foregroundColor(validPortFilterA ? Color.primary : Color.red)
                TextField("Port Filter", text: $portFilterB)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(validPortFilterB ? Color.primary : Color.red)
            }
            VStack {
                Picker(selection: $layer2Filter, label: Text("")) {
                    ForEach(Layer2Filter.allCases) { filtercase in
                        Text(filtercase.rawValue).tag(filtercase)
                    }
                }

                Picker(selection: $layer3Filter, label: Text("")) {
                    ForEach(Layer3Filter.allCases) { filtercase in
                        Text(filtercase.rawValue).tag(filtercase)
                    }
                }
                Picker(selection: $layer4Filter, label: Text("")) {
                    ForEach(Layer4Filter.allCases) { filtercase in
                        Text(filtercase.rawValue).tag(filtercase)
                    }
                }
            }
            VStack {
                Text("IPv4/IPv6 Filters:").fontWeight(.semibold)
                TextField("IP Address Filter", text: $ipFilterA)
                    .textFieldStyle(RoundedBorderTextFieldStyle()).foregroundColor(validIpA ? Color.primary : Color.red)
                TextField("IP Address Filter", text: $ipFilterB)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(validIpB ? Color.primary : Color.red)
            }
            VStack {
                Button("Reset All Filters") {
                    self.layer2Filter = .any
                    self.layer3Filter = .any
                    self.layer4Filter = .any
                    self.portFilterA = ""
                    self.portFilterB = ""
                    self.ipFilterA = ""
                    self.ipFilterB = ""
                }
                Button("Export All Frames") {
                    self.appDelegate.exportPcap(frames: self.frames)
                }
                Button("Export Filtered Frames") {
                    self.appDelegate.exportPcap(frames: self.filteredFrames)
                }
            }
        }.padding().background(Color.blue.opacity(0.7))
    }
}

struct DisplayFilterView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayFilterView(layer2Filter: .constant(.any), layer3Filter: .constant(.any), layer4Filter: .constant(.any), portFilterA: .constant(""), portFilterB: .constant(""), ipFilterA: .constant(""), ipFilterB: .constant(""), frames: .constant([]), filteredFrames: [])
    }
}
