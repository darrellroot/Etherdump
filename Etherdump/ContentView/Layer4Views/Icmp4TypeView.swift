//
//  Icmp4TypeView.swift
//  Etherdump
//
//  Created by Darrell Root on 3/16/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI
import PackageEtherCapture

struct Icmp4TypeView: View {
    @EnvironmentObject var highlight: Highlight
    //var icmpType: Icmp4Type
    var icmp: Icmp4
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
        case .addressMaskRequest(let identifier, let sequence, let mask):
            return AnyView(HStack {
                Text("DEPRECATED")
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
                Text("mask \(mask.debugDescription)")
                    .onTapGesture {
                        self.highlight.start = self.icmp.startIndex[.mask]
                        self.highlight.end = self.icmp.endIndex[.mask]
                }
            })
        case .addressMaskReply(let identifier, let sequence, let mask):
            return AnyView(HStack {
                Text("DEPRECATED")
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
                Text("mask \(mask.debugDescription)")
                    .onTapGesture {
                        self.highlight.start = self.icmp.startIndex[.mask]
                        self.highlight.end = self.icmp.endIndex[.mask]
                }
            })
        case .timestampRequest(let identifier, let sequence, let originate, let receive, let transmit):
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
                Text("originate \(originate)")
                    .onTapGesture {
                        self.highlight.start = self.icmp.startIndex[.originate]
                        self.highlight.end = self.icmp.endIndex[.originate]
                }
                Text("receive \(receive)")
                    .onTapGesture {
                        self.highlight.start = self.icmp.startIndex[.receive]
                        self.highlight.end = self.icmp.endIndex[.receive]
                }
                Text("transmit \(transmit)")
                    .onTapGesture {
                        self.highlight.start = self.icmp.startIndex[.transmit]
                        self.highlight.end = self.icmp.endIndex[.transmit]
                }
            })
        case .timestampReply(let identifier, let sequence, let originate, let receive, let transmit):
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
                Text("originate \(originate)")
                    .onTapGesture {
                        self.highlight.start = self.icmp.startIndex[.originate]
                        self.highlight.end = self.icmp.endIndex[.originate]
                }
                Text("receive \(receive)")
                    .onTapGesture {
                        self.highlight.start = self.icmp.startIndex[.transmit]
                        self.highlight.end = self.icmp.endIndex[.transmit]
                }
                Text("transmit \(transmit)")
            })
        case .netUnreachable,.hostUnreachable,.portUnreachable,.protocolUnreachable,.fragmentationNeeded,.sourceRouteFailed:
            return AnyView(HStack {
                Text("PayloadLength \(icmp.payloadLength)")
                    .onTapGesture {
                        self.highlight.start = self.icmp.startIndex[.payloadLength]
                        self.highlight.end = self.icmp.endIndex[.payloadLength]
                }
            })
        case .otherUnreachable(let code):
            return AnyView(HStack {
                Text("Code \(code)")
                .onTapGesture {
                    self.highlight.start = self.icmp.startIndex[.code]
                    self.highlight.end = self.icmp.endIndex[.code]
                }
                Text("PayloadLength \(icmp.payloadLength)")
                    .onTapGesture {
                        self.highlight.start = self.icmp.startIndex[.payloadLength]
                        self.highlight.end = self.icmp.endIndex[.payloadLength]
                    }
                })
        case .ttlExceeded,.fragmentReassemblyTimeExceeded:
            return AnyView(Text("PayloadLength \(icmp.payloadLength)")
                .onTapGesture {
                    self.highlight.start = self.icmp.startIndex[.payloadLength]
                    self.highlight.end = self.icmp.endIndex[.payloadLength]
                })
        case .parameterProblem(let pointer):
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
        case .sourceQuench:
            return AnyView(Text("DEPRECATED RFC 6633"))
        case .redirectHost(let ipv4),.redirectNetwork(let ipv4), .redirectTosHost(let ipv4), .redirectTosNetwork(let ipv4):
            return AnyView(Text("\(ipv4.debugDescription)"))
        case .informationRequest(let identifier, let sequence):
            return AnyView(HStack {
                Text("DEPRECATED")
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
        case .informationReply(let identifier,let sequence):
            return AnyView(HStack {
                Text("DEPRECATED")
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
            }//switch icmpType

    }
}

struct Icmp4TypeView_Previews: PreviewProvider {
    static var previews: some View {
        guard case .icmp4(let icmp4) = Frame.sampleFrameIcmp4.layer4 else {
            print("fatal error")
            fatalError()
        }
        
        return Icmp4TypeView(icmp: icmp4)
            .environmentObject(AppSettings()).font(.system(.body, design: .monospaced))

    }
}
