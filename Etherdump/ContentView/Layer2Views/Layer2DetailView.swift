//
//  Layer2DetailView.swift
//  Etherdump
//
//  Created by Darrell Root on 1/31/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI
import PackageEtherCapture

struct Layer2DetailView: View {
    
    @Binding var frame: Frame?
    
    @EnvironmentObject var highlight: Highlight
    //@Binding var startHighlight: Data.Index?
    //@Binding var endHighlight: Data.Index?
    var body: some View {
/*        HStack {
            Text(frame?.frameFormat.rawValue ?? "Frame").font(.headline)
            Spacer()
            Text(frame?.verboseDescription ?? "Error displaying frame header")
            Spacer()
*/
        HStack {
            Text(frame?.frameFormat.rawValue ?? "Frame").font(.headline)
            Spacer()
            VStack(alignment: .leading) {
                HStack {
                    Text(frame?.srcmac ?? "unknown").onTapGesture {
                        self.highlight.start = self.frame?.startIndex[.srcmac]
                        self.highlight.end = self.frame?.endIndex[.srcmac]
                    }
                    Text(">")
                    Text(frame?.dstmac ?? "unknown").onTapGesture {
                        self.highlight.start = self.frame?.startIndex[.dstmac]
                        self.highlight.end = self.frame?.endIndex[.dstmac]
                    }
                    frame?.ieeeLength.map { Text("Len \($0)")
                        .onTapGesture {
                            self.highlight.start = self.frame?.startIndex[.ieeeLength]
                            self.highlight.end = self.frame?.endIndex[.ieeeLength]
                        }
                    }
                    frame?.ethertype.map { Text("Ethertype \($0.hex4)")
                        .onTapGesture {
                            self.highlight.start = self.frame?.startIndex[.ethertype]
                            self.highlight.end = self.frame?.endIndex[.ethertype]
                        }
                    }
                }//HStack
                HStack {
                    frame?.ieeeDsap.map { Text("DSAP \($0.hex)")
                        .onTapGesture {
                            self.highlight.start = self.frame?.startIndex[.ieeeDsap]
                            self.highlight.end = self.frame?.endIndex[.ieeeDsap]
                        }
                    }
                    frame?.ieeeSsap.map { Text("SSAP \($0.hex)")
                        .onTapGesture {
                            self.highlight.start = self.frame?.startIndex[.ieeeSsap]
                            self.highlight.end = self.frame?.endIndex[.ieeeSsap]
                        }
                    }
                    frame?.ieeeControl.map { Text("CTRL \($0.hex)")
                        .onTapGesture {
                            self.highlight.start = self.frame?.startIndex[.ieeeControl]
                            self.highlight.end = self.frame?.endIndex[.ieeeControl]
                        }
                    }
                    frame?.snapOrg.map { Text("ORG \($0.hex6)")
                        .onTapGesture {
                            self.highlight.start = self.frame?.startIndex[.snapOrg]
                            self.highlight.end = self.frame?.endIndex[.snapOrg]
                        }
                    }
                    frame?.snapType.map { Text("SnapType \($0.hex4)")
                        .onTapGesture {
                            self.highlight.start = self.frame?.startIndex[.snapType]
                            self.highlight.end = self.frame?.endIndex[.snapType]
                        }
                    }
                    frame?.padding.map {  Text("Padding \($0.count) Bytes")
                        .onTapGesture {
                            self.highlight.start = self.frame?.startIndex[.padding]
                            self.highlight.end = self.frame?.endIndex[.padding]
                        }
                    }
                }//HStack
        }//VStack
        Spacer()
    }.padding().cornerRadius(8).border(Color.green.opacity(0.7),width: 2).padding()
    }
}

struct Layer2DetailView_Previews: PreviewProvider {
    static var previews: some View {
        Layer2DetailView(frame: .constant(Frame.sampleFrame)).environmentObject(Highlight())
    }
}
