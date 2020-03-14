//
//  FrameHexView.swift
//  Etherdump
//
//  Created by Darrell Root on 3/12/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI
import PackageEtherCapture

struct FrameHexView: View {
    @Binding var frame: Frame?
    @Binding var startHighlight: Data.Index?
    @Binding var endHighlight: Data.Index?
    var body: some View {
        guard let frame = frame else { return Text("")}
        var retval = Text("")
        let start = startHighlight ?? 0
        let end = endHighlight ?? 0
        for (position,datum) in frame.data.enumerated() {
            let dataIndex = position + frame.data.startIndex  //startIndex is not 0 if imported from pcap file
            switch (position % 2 == 0, position % 16 == 0, position % 16 == 15, dataIndex >= start, dataIndex < end) {
            case (false, false, false, true, true): // odd positions
                retval = retval + Text(datum.plainhex).fontWeight(.bold) + Text(" ")
            case (false, false, false, _, _): // odd positions
                retval = retval + Text(datum.plainhex) + Text(" ")
            case (false, false, true, true, true): // end of line, odd
                retval = retval + Text(datum.plainhex).fontWeight(.bold) + Text("\n")
            case (false, false, true, _ , _): // end of line, odd
                retval = retval + Text(datum.plainhex) + Text("\n")
            case (true, true, false, true, true):  // beginning of line, even
                retval = retval + Text(position.hex4)
                retval = retval + Text(" ")
                retval = retval + Text(datum.plainhex).fontWeight(.bold)
            case (true, true, false, _ , _):  // beginning of line, even
                retval = retval + Text(position.hex4)
                retval = retval + Text(" ")
                retval = retval + Text(datum.plainhex)
            case (true, false, false, true, true): // even but not beginning of line
                retval = retval + Text(datum.plainhex).fontWeight(.bold)
            case (true, false, false, _ , _): // even but not beginning of line
                retval = retval + Text(datum.plainhex)
            case (false, true, false, _ , _),(false, true, true, _ , _),(true, false, true, _ , _),(true, true, true, _ , _):  // invalid cases
                EtherCapture.logger.error("unexpected hexdump case")
            }
        }
        return retval
    }
}

struct FrameHexView_Previews: PreviewProvider {
    static var previews: some View {
        FrameHexView(frame: .constant(Frame.sampleFrame), startHighlight: .constant(nil), endHighlight: .constant(nil))
    }
}
