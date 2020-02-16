//
//  AlertView.swift
//  Etherdump
//
//  Created by Darrell Root on 2/15/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI

struct AlertView: View {
    @State var alertIsShowing: Bool = true
    @State var textMessage: String
    var body: some View {
        Text("").alert(isPresented: $alertIsShowing) {
        Alert(title: Text("Alert"),
          message: Text("\(textMessage)"),
          dismissButton: .default(Text("OK")) {
            NSApplication.shared.keyWindow?.close()
            })
        }
    }
}

/*struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView()
    }
}*/
