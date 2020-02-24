//
//  DisplayFilterView.swift
//  Etherdump
//
//  Created by Darrell Root on 2/7/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI
import PackageEtherCapture

struct DisplayFilterView: View {
    @Binding var layer3Filter: Layer3Filter
    @Binding var layer4Filter: Layer4Filter
    @Binding var portFilterA: String
    @Binding var portFilterB: String

    var body: some View {
        HStack {
            Text("Filter Controls:").fontWeight(.semibold)
            Picker(selection: $layer3Filter, label: Text("")) {
                ForEach(Layer3Filter.allCases) { filtercase in
                    Text(filtercase.rawValue).tag(filtercase)
                }
            }
            Picker(selection: $layer4Filter, label: Text("")) {
                ForEach(Layer4Filter.allCases) { filtercase in
                    Text(filtercase.rawValue).tag(filtercase)
                }
            }
            TextField("Port Filter", text: $portFilterA)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Port Filter", text: $portFilterB)
                .textFieldStyle(RoundedBorderTextFieldStyle())

        }.padding().background(Color.blue.opacity(0.7))
    }
}

struct DisplayFilterView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayFilterView(layer3Filter: .constant(.any), layer4Filter: .constant(.any), portFilterA: .constant(""), portFilterB: .constant(""))
    }
}
