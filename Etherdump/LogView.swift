//
//  LogView.swift
//  Etherdump
//
//  Created by Darrell Root on 2/13/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI

struct LogView: View {
    @ObservedObject var logHandler = DarrellLogHandler.shared
    var body: some View {
        ScrollView {
            Text("                                    ")
            //Text(DarrellLogHandler.shared.logData)
            Text(logHandler.logData)
        }
    }
}

struct LogView_Previews: PreviewProvider {
    static var previews: some View {
        LogView()
    }
}
