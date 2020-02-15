//
//  LogView.swift
//  Etherdump
//
//  Created by Darrell Root on 2/13/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI

struct LogView: View {
    var body: some View {
        ScrollView {
            Text(DarrellLogHandler.shared.logData)
        }
    }
}

struct LogView_Previews: PreviewProvider {
    static var previews: some View {
        LogView()
    }
}
