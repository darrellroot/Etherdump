//
//  Layer3DetailView.swift
//  Etherdump
//
//  Created by Darrell Root on 1/31/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI
import PackageEtherCapture

struct Layer3DetailView: View {
    @Binding var frame: Frame?
    var body: some View {
        Text(frame?.layer3.verboseDescription ?? "Error displaying layer-3 header")
    }
}

struct Layer3DetailView_Previews: PreviewProvider {
    static var previews: some View {
        Layer3DetailView(frame: .constant(Frame.sampleFrame))
    }
}
