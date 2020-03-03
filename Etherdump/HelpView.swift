//
//  HelpView.swift
//  Etherdump
//
//  Created by Darrell Root on 2/24/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

//not currently used
/*import SwiftUI

struct HelpView: View {
    @EnvironmentObject var appSettings: AppSettings

    var body: some View {
        VStack {
            Text("\(BuildConfiguration.appName) Help").font(.title)
            Text(" ")
            Text("feedback@networkmom.net")
            Text(" ")
            VStack(alignment: .leading) {
                Group {
                Text("\(BuildConfiguration.appName) is a tool to view ethernet frame captures.")
                Text(" ")
                Text("You can import a .pcap or .pcapng packet capture from another tool using the \"File->Import PCAP\" menu item").fixedSize(horizontal: false, vertical: true).lineLimit(2)
                Text(" ")
                Text("The full \"Etherdump\" version downloadable from https://etherdump.net supports live packet capture on the MacOS network interface.  The full \"Etherdump\" version is notarized by Apple but is not sandboxed.").fixedSize(horizontal: false, vertical: true).lineLimit(4)
                Text(" ")
                Text("The \"Etherdump Lite\" version available in the MacOS App Store does not support live packet capture, because that functionality is not compatible with the sandbox security required by the MacOS App Store").fixedSize(horizontal: false, vertical: true).lineLimit(4)
                }
                Group {
                Text(" ")
                Text("\"Etherdump\" and \"Etherdump Lite\" are Open Source at https://github.com/darrellroot/Etherdump").font(.headline)
                Text(" ")
                Text("Etherdump uses the following Open Source swift packages:").font(.headline)
                Text(" ")
                    Group {Text("PackageEtherCapture").font(.headline) + Text(" https://github.com/darrellroot/PackageEtherCapture for capturing and decoding Ethernet frames")}.fixedSize(horizontal: false, vertical: true).lineLimit(2)
                }
                Group {
                Text("PackageSwiftPcapng").font(.headline) + Text(" https://github.com/darrellroot/PackageSwiftPcapng for opening and saving .pcap and .pcapng files")}.fixedSize(horizontal: false, vertical: true).lineLimit(2)
                Group {
                    Text("Swift-Log API").font(.headline) + Text(" https://github.com/apple/swift-log")
                Text(" ")
                }
                Group {
                    Text("Frame Decodes Supported In Version 1.0 February 2020").font(.headline)
                    Text("Layer 2: Ethernet, 802.3")
                    Text("Layer 3: IPv4, IPv6")
                    Text("Layer 4: TCP, UDP")
                    Text(" ")
                    Text("Etherdump and PackageEtherCapture welcome pull requests for additional decodes.  But all submissions will be carefully reviewed.").fixedSize(horizontal: false, vertical: true).lineLimit(2)
                }
            }
        }.font(appSettings.font)
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView().environmentObject(AppSettings())
    }
}
 */
