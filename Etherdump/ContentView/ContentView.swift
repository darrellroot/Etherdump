//
//  ContentView.swift
//  Etherdump
//
//  Created by Darrell Root on 1/30/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI
import PackageEtherCapture
import Network


class Highlight: ObservableObject {
    @Published var start: Data.Index? = nil
    @Published var end: Data.Index? = nil
}

struct ContentView: View {
    let showCapture: Bool
    //@Environment(\.font) var font
    var highlight = Highlight()
    @EnvironmentObject var appSettings: AppSettings
    @State var frames: [Frame] = []
    @State var activeFrame: Frame? = nil
    @State var layer2Filter: Layer2Filter = .any
    @State var layer3Filter: Layer3Filter = .any
    @State var layer4Filter: Layer4Filter = .any
    @State var portFilterA: String = ""
    @State var portFilterB: String = ""
    @State var ipFilterA: String = ""
    @State var ipFilterB: String = ""
    //@State var startHighlight: Data.Index? = nil
    //@State var endHighlight: Data.Index? = nil
    let appDelegate = NSApplication.shared.delegate as! AppDelegate
    let windowCount: Int
    
    init(frames: [Frame] = [], showCapture: Bool, windowCount: Int) {
        self.windowCount = windowCount
        self.showCapture = showCapture
        _frames = State<[Frame]>(initialValue: frames)
    }
    var body: some View {
        VStack(spacing: 0) {
            if showCapture {
                CaptureFilterView(frames: self.$frames,interface: appSettings.interfaces.first ?? "en0", activeFrame: self.$activeFrame)
            }
            DisplayFilterView(layer2Filter: $layer2Filter, layer3Filter: $layer3Filter, layer4Filter: $layer4Filter, portFilterA: $portFilterA, portFilterB: $portFilterB, ipFilterA: $ipFilterA, ipFilterB: $ipFilterB, frames: $frames, filteredFrames: filteredFrames)
            FrameSummaryView(frames: $frames,filteredFrames: filteredFrames,activeFrame:  $activeFrame , portFilterA: $portFilterA, portFilterB: $portFilterB)
            if activeFrame != nil {
                Layer2DetailView(frame: $activeFrame)
            }
            if activeFrame != nil {
                Layer3DetailView(frame: $activeFrame)
            }
            if activeFrame != nil {
                Layer4DetailView(frame: $activeFrame)
            }
            if activeFrame != nil {
                FrameHexView(frame: $activeFrame)
            }
            //Text(activeFrame?.hexdump ?? "")
            }.environmentObject(highlight).onDisappear() {
            self.appDelegate.deleteWindow(windowCount: self.windowCount)
        }
            
            //.frame(maxWidth: .infinity, maxHeight: .infinity)
            //.frame(idealWidth: 1000, idealHeight: 1000)
            .font(appSettings.font)
            /*.onCommand(#selector(AppDelegate.exportAllPcap(_:))) {
                DarrellLogHandler.logger.error("export all Pcap")
                self.appDelegate.exportPcap(frames: self.frames)
            }
            .onCommand(#selector(AppDelegate.exportFilteredPcap(_:))) {
                DarrellLogHandler.logger.error("export filtered Pcap")
                self.appDelegate.exportPcap(frames: self.filteredFrames)
        }*/
    
    }
    func port(_ portString: String) -> Int? {
        //returns port number if valid port, nil otherwise
        guard let port = Int(portString) else {
            return nil
        }
        guard port >= 0 && port <= 65535 else {
            return nil
        }
        return port
    }
    var filteredFrames: [Frame] {
        var outputFrames: [Frame] = []
        let capacity = frames.capacity
        outputFrames.reserveCapacity(capacity)
        frameloop: for frame in frames {
            
            switch (frame.layer3, layer2Filter) {
            case (_, .any):
                break
            case (.arp, .arp):
                break
            case (.bpdu, .bpdu):
                break
            case (.cdp, .cdp):
                break
            case (.lldp, .lldp):
                break
            case (_,.arp),(_,.bpdu),(_,.cdp),(_,.lldp):
                continue frameloop
            }
                            
            switch (frame.layer3, layer3Filter) {
            
            case (_, .any):
                break
            case (.ipv4,.ipv4):
                break
            case (_,.ipv4):
                continue frameloop
            case (.ipv6,.ipv6):
                break
            case (_,.ipv6):
                continue frameloop
            case (.ipv4,.nonIp),(.ipv6,.nonIp):
                continue frameloop
            case (.arp,.nonIp),(.bpdu,.nonIp),(.cdp,.nonIp),(.lldp,.nonIp),(.unknown,.nonIp):
                break
            }
            
            switch (frame.layer3, ipFilterA.validIPv4, ipFilterB.validIPv4) {
            case (_, .none, .none):
                break
            case (.ipv4(let ipv4), .some(let filterAddressA), .some(let filterAddressB)):
                if ipv4.sourceIP == filterAddressA && ipv4.destinationIP == filterAddressB {
                    break  // pass
                }
                if ipv4.sourceIP == filterAddressB && ipv4.destinationIP == filterAddressA {
                    break  //pass
                }
                continue frameloop  // fail
                case (.ipv4(let ipv4),.some(let filterAddress),_),(.ipv4(let ipv4),_,.some(let filterAddress)):
                    guard ipv4.sourceIP == filterAddress || ipv4.destinationIP == filterAddress else {
                        continue frameloop  // fail
                    }
                    break // pass
                case (_, _, _):  // frame is not ipv6, but at least one ipv6 filter exists
                    continue frameloop
            }
            switch (frame.layer3, IPv6Address(ipFilterA), IPv6Address(ipFilterB)) {
            case (_, .none, .none):
                break
            case (.ipv6(let ipv6),.some(let filterAddressA),.some(let filterAddressB)):
                if ipv6.sourceIP == filterAddressA && ipv6.destinationIP == filterAddressB {
                    break  // pass
                }
                if ipv6.sourceIP == filterAddressB && ipv6.destinationIP == filterAddressA {
                    break  //pass
                }
                continue frameloop  // fail
            case (.ipv6(let ipv6),.some(let filterAddress),_),(.ipv6(let ipv6),_,.some(let filterAddress)):
                guard ipv6.sourceIP == filterAddress || ipv6.destinationIP == filterAddress else {
                    continue frameloop  // fail
                }
                break // pass
            case (_, _, _):  // frame is not ipv6, but at least one ipv6 filter exists
                continue frameloop
            }//switch frame layer3 IPv6
            
            if let layer4 = frame.layer4 {
                switch (layer4, layer4Filter) {
                case (.tcp,.tcp),(.udp,.udp),(.icmp4,.icmp),(.icmp6,.icmp),(_,.any):
                    break
                case (_,.tcp),(_,.udp),(_,.icmp):
                    continue frameloop
                }
            } else {
                switch layer4Filter {
                case .any:
                    break
                case .tcp:
                    continue frameloop
                case .udp:
                    continue frameloop
                case .icmp:
                    continue frameloop
                }
            }
            switch (port(portFilterA),port(portFilterB)) {
            case (.none, .none):
                break
            case (.some(let filterPort), .none),(.none, .some(let filterPort)):
                guard let layer4 = frame.layer4 else {
                    //not tcp or udp so filter it!
                    continue frameloop
                }
                switch layer4 {
                    case .tcp(let tcp):
                        if tcp.sourcePort != filterPort && tcp.destinationPort != filterPort {
                            continue frameloop
                        }
                    case .udp(let udp):
                        if udp.sourcePort != filterPort && udp.destinationPort != filterPort {
                            continue frameloop
                        }
                    default:
                        //not tcp or udp so filter it!
                        continue frameloop
                }
                case (.some(let portA), .some(let portB)):
                    guard let layer4 = frame.layer4 else {
                        //not tcp or udp so filter it!
                        continue frameloop
                    }
                    switch layer4 {
                    case .tcp(let tcp):
                        if (tcp.sourcePort != portA || tcp.destinationPort != portB) && (tcp.sourcePort != portB || tcp.destinationPort != portA) {
                            continue frameloop
                        }
                    case .udp(let udp):
                        if (udp.sourcePort != portA || udp.destinationPort != portB) && (udp.sourcePort != portB || udp.destinationPort != portA) {
                            continue frameloop
                        }
                    default:
                        //not tcp or udp so filter it!
                        continue frameloop
                    }
                }// switch portFilterAB
            
            outputFrames.append(frame)
        }//frameloop
        return outputFrames
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //ContentView(frames: [Frame.sampleFrame], showCapture: true, appSettings: AppSettings())
        ContentView(frames: [Frame.sampleFrame], showCapture: false, windowCount: 1).environmentObject(AppSettings())

        
    }
}
