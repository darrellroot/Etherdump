//
//  Icmp6TypeView.swift
//  Etherdump
//
//  Created by Darrell Root on 3/16/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI
import PackageEtherCapture

struct Icmp6TypeView: View {
    @EnvironmentObject var highlight: Highlight
    //var icmpType: Icmp6Type
    var icmp: Icmp6
    var body: some View {
        let icmpType = icmp.icmpType
        switch icmpType {
            
        case .other:
            return AnyView(Text("unable to further analyze"))
        case .echoReply(let identifier, let sequence):
            return AnyView(HStack {
                Text("id \(identifier)")
                    .onTapGesture {
                        self.highlight.start = self.icmp.startIndex[.identifier]
                        self.highlight.end = self.icmp.endIndex[.identifier]
                }
                Text("sequence \(sequence)")
                    .onTapGesture {
                        self.highlight.start = self.icmp.startIndex[.sequence]
                        self.highlight.end = self.icmp.endIndex[.sequence]
                }
            })
        case .echoRequest(let identifier, let sequence):
            return AnyView(HStack {
                Text("id \(identifier)")
                    .onTapGesture {
                        self.highlight.start = self.icmp.startIndex[.identifier]
                        self.highlight.end = self.icmp.endIndex[.identifier]
                }
                Text("sequence \(sequence)")
                    .onTapGesture {
                        self.highlight.start = self.icmp.startIndex[.sequence]
                        self.highlight.end = self.icmp.endIndex[.sequence]
                }
            })
        case .parameterProblem(let code, let pointer):
            return AnyView(HStack {
                Text("Pointer: \(pointer)")
                .onTapGesture {
                    self.highlight.start = self.icmp.startIndex[.pointer]
                    self.highlight.end = self.icmp.endIndex[.pointer]
                }
                Text("PayloadLength \(icmp.payloadLength)")
                .onTapGesture {
                    self.highlight.start = self.icmp.startIndex[.payloadLength]
                    self.highlight.end = self.icmp.endIndex[.payloadLength]
                }
            })
        case .unreachableNoRoute:
            return AnyView(EmptyView())
        case .unreachableProhibited:
            return AnyView(EmptyView())
        case .unreachableScope:
            return AnyView(EmptyView())
        case .unreachableAddress:
            return AnyView(EmptyView())
        case .unreachablePort:
            return AnyView(EmptyView())
        case .unreachableSource:
            return AnyView(EmptyView())
        case .unreachableRejectRoute:
            return AnyView(EmptyView())
        case .packetTooBig:
            return AnyView(EmptyView())
        case .hopLimitExceeded:
            return AnyView(EmptyView())
        case .fragmentReassemblyTimeExceeded:
            return AnyView(EmptyView())
        case .neighborSolicitation(let target):
            return AnyView(Text("Target \(target.debugDescription)")
                .onTapGesture {
                    self.highlight.start = self.icmp.startIndex[.target]
                    self.highlight.end = self.icmp.endIndex[.target]
            })
        case .neighborAdvertisement(let target, let router, let solicited, let override):
            return AnyView(HStack {
                Text("Target \(target.debugDescription)")
                    .onTapGesture {
                        self.highlight.start = self.icmp.startIndex[.target]
                        self.highlight.end = self.icmp.endIndex[.target]
                }
                Text("Router \(router.description)")
                    .onTapGesture {
                        self.highlight.start = self.icmp.startIndex[.flags]
                        self.highlight.end = self.icmp.endIndex[.flags]
                }
                Text("Solicited: \(solicited.description)")
                    .onTapGesture {
                        self.highlight.start = self.icmp.startIndex[.flags]
                        self.highlight.end = self.icmp.endIndex[.flags]
                }
                Text("Override: \(override.description)")
                    .onTapGesture {
                        self.highlight.start = self.icmp.startIndex[.flags]
                        self.highlight.end = self.icmp.endIndex[.flags]
                }
            })
        case .redirect(let target, let destination):
                        return AnyView(HStack {
                Text("Target \(target.debugDescription)")
                    .onTapGesture {
                        self.highlight.start = self.icmp.startIndex[.target]
                        self.highlight.end = self.icmp.endIndex[.target]
                }
                Text("Destination \(destination.debugDescription)")
                    .onTapGesture {
                        self.highlight.start = self.icmp.startIndex[.destination]
                        self.highlight.end = self.icmp.endIndex[.destination]
                    }
            })
        }//switch icmpType

    }
}

struct Icmp6TypeView_Previews: PreviewProvider {
    static var previews: some View {
        guard case .icmp6(let icmp6) = Frame.sampleFrameIcmp6.layer4 else {
            print("fatal error")
            fatalError()
        }
        
        return Icmp6TypeView(icmp: icmp6)
            .environmentObject(AppSettings()).font(.system(.body, design: .monospaced))

    }
}
