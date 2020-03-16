//
//  TcpDetailView.swift
//  Etherdump
//
//  Created by Darrell Root on 2/7/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI
import PackageEtherCapture

struct TcpDetailView: View {
    var tcp: Tcp
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var highlight: Highlight
    var body: some View {
        VStack (spacing:12){
            HStack{
                Text("TCP").font(.headline)
                Spacer()
            }
            HStack{
                VStack (alignment: .leading, spacing:6 ){
                    HStack{
                        Text("\(tcp.sourcePort)")
                            .onTapGesture {
                                self.highlight.start = self.tcp.startIndex[.sourcePort]
                                self.highlight.end = self.tcp.endIndex[.sourcePort]
                        }
                        Text(">")
                        Text("\(tcp.destinationPort)")
                            .onTapGesture {
                                self.highlight.start = self.tcp.startIndex[.destinationPort]
                                self.highlight.end = self.tcp.endIndex[.destinationPort]
                        }
                    }
                    HStack{
                        Text("Flags: \(tcp.flags)")
                            .onTapGesture {
                                self.highlight.start = self.tcp.startIndex[.flags]
                                self.highlight.end = self.tcp.endIndex[.flags]
                        }
                    }
                    Group{
                        HStack {
                            Text(verbatim: "Seq: \(tcp.sequenceNumber)")
                                .onTapGesture {
                                    self.highlight.start = self.tcp.startIndex[.sequenceNumber]
                                    self.highlight.end = self.tcp.endIndex[.sequenceNumber]
                            }
                        }
                        HStack{
                            Text(verbatim: "Ack: \(tcp.acknowledgementNumber)")
                                .onTapGesture {
                                    self.highlight.start = self.tcp.startIndex[.acknowledgementNumber]
                                    self.highlight.end = self.tcp.endIndex[.acknowledgementNumber]
                            }
                        }
                        HStack{
                            Text(verbatim: "Window: \(tcp.window)")
                                .onTapGesture {
                                    self.highlight.start = self.tcp.startIndex[.window]
                                    self.highlight.end = self.tcp.endIndex[.window]
                            }
                        }
                        HStack{
                            Text(verbatim: "Urgent: \(tcp.urgentPointer)")
                                .onTapGesture {
                                    self.highlight.start = self.tcp.startIndex[.urgentPointer]
                                    self.highlight.end = self.tcp.endIndex[.urgentPointer]
                            }
                        }
                        HStack{
                            Text(verbatim: "Offset: \(tcp.dataOffset)")
                                .onTapGesture {
                                    self.highlight.start = self.tcp.startIndex[.dataOffset]
                                    self.highlight.end = self.tcp.endIndex[.dataOffset]
                            }
                        }
                        HStack{
                            Text("Payload: \(tcp.payload.count) bytes")
                                .onTapGesture {
                                    self.highlight.start = self.tcp.startIndex[.payload]
                                    self.highlight.end = self.tcp.endIndex[.payload]
                            }
                        }
                    }
                    
                }
                HStack{
                    if tcp.payload.count < 150 {
                        PayloadView(payload: tcp.payload)
                            .onTapGesture {
                                self.highlight.start = self.tcp.startIndex[.payload]
                                self.highlight.end = self.tcp.endIndex[.payload]
                            }
                    } else {
                        Spacer()
                    }
                }
            }.font(appSettings.font)
                .padding().cornerRadius(8).border(Color.black.opacity(0),
                                                  width: 0).padding(1).background(Color.black.opacity(0.4))
            
        }.padding().cornerRadius(8).border(tcp.rst ? Color.red.opacity(0.7) : Color.green.opacity(0.7), width: 2).padding()
    }
}

struct TcpDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        guard case .tcp(let tcp) = Frame.sampleFrame.layer4 else {
            print("fatal error")
            fatalError()
        }
        return TcpDetailView(tcp: tcp)
            .environmentObject(AppSettings()).font(.system(.body, design: .monospaced))
    }
}
