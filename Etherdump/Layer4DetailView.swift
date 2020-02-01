//
//  Layer4DetailView.swift
//  Etherdump
//
//  Created by Darrell Root on 1/31/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI
import PackageEtherCapture

struct Layer4DetailView: View {
    @Binding var frame: Frame?
    var body: some View {
        Text(frame?.layer4?.verboseDescription ?? "Error displaying layer-4 header")
    }
}

struct Layer4DetailView_Previews: PreviewProvider {
    static var previews: some View {
        Layer4DetailView(frame: .constant(Frame.sampleFrame))
    }
}
