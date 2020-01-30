//
//  ContentView.swift
//  Etherdump
//
//  Created by Darrell Root on 1/30/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    fileprivate func extractedFunc() -> Text {
        return Text("Capture Filter")
    }
    
    var body: some View {
        VStack {
            extractedFunc()
            Text("Display Filter")
            Text("Packet Summary")
            Text("Packet Detail")
            Text("Packet Hexdump")
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
