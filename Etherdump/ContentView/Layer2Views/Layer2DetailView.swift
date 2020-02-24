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
    var body: some View {
         Text(frame?.verboseDescription ?? "Error displaying frame header")
    }
}

struct Layer2DetailView_Previews: PreviewProvider {
    static var previews: some View {
        Layer2DetailView(frame: .constant(Frame.sampleFrame))
    }
}
