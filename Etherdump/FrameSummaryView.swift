//
//  FrameSummaryView.swift
//  Etherdump
//
//  Created by Darrell Root on 1/31/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI
import PackageEtherCapture

struct FrameSummaryView: View {
    @EnvironmentObject var appSettings: AppSettings
    @Binding var frames: [Frame]
    @Binding var activeFrame: Frame?
    @Binding var layer3Filter: Layer3Filter
    @Binding var layer4Filter: Layer4Filter
    @Binding var portFilterA: String
    @Binding var portFilterB: String
    
    var filteredFrames: [Frame] {
        var outputFrames = frames
        
        switch layer3Filter {
        case .any:
            break
        case .ipv4:
            for (position,frame) in outputFrames.enumerated().reversed() {
                if case .ipv4(_) = frame.layer3 {
                //if false {
                    continue
                } else {
                    outputFrames.remove(at: position)
                }
            }
        case .ipv6:
            for (position,frame) in outputFrames.enumerated().reversed() {
                if case .ipv6(_) = frame.layer3 {
                    continue
                } else {
                    outputFrames.remove(at: position)
                }
            }
        case .nonIp:
            for (position,frame) in outputFrames.enumerated().reversed() {
                if case .ipv4(_) = frame.layer3 {
                    outputFrames.remove(at: position)
                } else if case .ipv6(_) = frame.layer3 {
                    outputFrames.remove(at: position)
                } else {
                    continue
                }
            }
        }
        
        switch layer4Filter {
        case .any:
            break
        case .tcp:
            for (position,frame) in outputFrames.enumerated().reversed() {
                if case .tcp(_) = frame.layer4 {
                    continue
                } else {
                    outputFrames.remove(at: position)
                }
            }
        case .udp:
            for (position,frame) in outputFrames.enumerated().reversed() {
                if case .udp(_) = frame.layer4 {
                    continue
                } else {
                    outputFrames.remove(at: position)
                }
            }
        case .icmp:
            debugPrint("icmp protocol not implemented in displayfilter")
        }
                
        switch (Int(portFilterA),Int(portFilterB)) {
        case (.none, .none):
            break
        case (.some(let filterPort), .none),(.none, .some(let filterPort)):
            for (position, frame) in outputFrames.enumerated().reversed() {
                guard let layer4 = frame.layer4 else {
                    //not tcp or udp so filter it!
                    outputFrames.remove(at: position)
                    continue
                }
                switch layer4 {
                case .tcp(let tcp):
                    if tcp.sourcePort != filterPort && tcp.destinationPort != filterPort {
                        outputFrames.remove(at: position)
                        continue
                    }
                case .udp(let udp):
                    if udp.sourcePort != filterPort && udp.destinationPort != filterPort {
                        outputFrames.remove(at: position)
                        continue
                    }
                default:
                    //not tcp or udp so filter it!
                    outputFrames.remove(at: position)
                    continue
                }
            }
        case (.some(let portA), .some(let portB)):
            for (position, frame) in outputFrames.enumerated().reversed() {
                guard let layer4 = frame.layer4 else {
                    //not tcp or udp so filter it!
                    outputFrames.remove(at: position)
                    continue
                }
                switch layer4 {
                case .tcp(let tcp):
                    if (tcp.sourcePort != portA || tcp.destinationPort != portB) && (tcp.sourcePort != portB || tcp.destinationPort != portA) {
                        outputFrames.remove(at: position)
                        continue
                    }
                case .udp(let udp):
                    if (udp.sourcePort != portA || udp.destinationPort != portB) && (udp.sourcePort != portB || udp.destinationPort != portA) {
                        outputFrames.remove(at: position)
                        continue
                    }
                default:
                    //not tcp or udp so filter it!
                    outputFrames.remove(at: position)
                    continue
                }
            }
        }
        return outputFrames
    }
    var body: some View {
        List(self.filteredFrames) { frame in
            Button(action: {
                self.activeFrame = frame
            }) {
                Text(frame.description).font(self.appSettings.font)
            }
        }.padding().background(Color.purple.opacity(0.7))
    }
}

struct FrameSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        FrameSummaryView(frames: .constant([Frame.sampleFrame]),activeFrame: .constant(Frame.sampleFrame),layer3Filter: .constant(.any), layer4Filter: .constant(.any), portFilterA: .constant(""), portFilterB: .constant(""))
    }
}
