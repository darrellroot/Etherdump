//
//  PayloadView.swift
//  Etherdump
//
//  Created by Darrell Root on 2/7/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI

struct PayloadView: View {
    var payload: Data
    var body: some View {
        HStack {
            Text("Payload").font(.headline)
            Text("\(payload.count) Bytes")
            Spacer()
            Text(payload.hexdump)
            Spacer()
        }.cornerRadius(8).border(Color.gray.opacity(0.7), width: 2).padding()
    }
}

struct PayloadView_Previews: PreviewProvider {
    static var previews: some View {
        PayloadView(payload: Data())
    }
}
