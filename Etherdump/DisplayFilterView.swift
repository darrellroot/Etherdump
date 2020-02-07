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
    @Binding var layer3Filter: FilterIpVersion
    var body: some View {
        HStack {
            Text("Filter Controls:").fontWeight(.semibold)
            Picker(selection: $layer3Filter, label: Text("")) {
                ForEach(FilterIpVersion.allCases) { filtercase in
                    Text(filtercase.rawValue).tag(filtercase)
                }
            }
        }.padding().background(Color.orange.opacity(0.7))
    }
}

struct DisplayFilterView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayFilterView(layer3Filter: .constant(.any))
    }
}
