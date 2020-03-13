//
//  ContentView.swift
//  Etherdump
//
//  Created by Darrell Root on 1/30/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI
import PackageEtherCapture




struct ContentView: View {
    let showCapture: Bool
    //@Environment(\.font) var font
    @EnvironmentObject var appSettings: AppSettings
    @State var frames: [Frame] = []
    @State var activeFrame: Frame? = nil
    @State var layer3Filter: Layer3Filter = .any
    @State var layer4Filter: Layer4Filter = .any
    @State var portFilterA: String = ""
    @State var portFilterB: String = ""
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
                CaptureFilterView(frames: self.$frames,interface: appSettings.interfaces.first ?? "en0")
            }
            DisplayFilterView(layer3Filter: $layer3Filter, layer4Filter: $layer4Filter, portFilterA: $portFilterA, portFilterB: $portFilterB, frames: $frames, filteredFrames: filteredFrames)
            FrameSummaryView(frames: $frames,filteredFrames: filteredFrames,activeFrame:  $activeFrame , layer3Filter: $layer3Filter, layer4Filter: $layer4Filter, portFilterA: $portFilterA, portFilterB: $portFilterB)
            if activeFrame != nil {
                Layer2DetailView(frame: $activeFrame)
            }
            if activeFrame != nil {
                Layer3DetailView(frame: $activeFrame)
            }
            if activeFrame != nil {
                Layer4DetailView(frame: $activeFrame)
            }
            Text(activeFrame?.hexdump ?? "")
        }.onDisappear() {
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
    var filteredFrames: [Frame] {
        var outputFrames: [Frame] = []
        let capacity = frames.capacity
        outputFrames.reserveCapacity(capacity)
        frameloop: for frame in frames {
                            
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
            switch (Int(portFilterA),Int(portFilterB)) {
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
                }
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
