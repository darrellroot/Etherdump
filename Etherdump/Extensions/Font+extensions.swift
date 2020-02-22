//
//  Font+extensions.swift
//  Etherdump
//
//  Created by Darrell Root on 2/22/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import Foundation
import SwiftUI
extension Font {
    var description: String {
        switch self {
            
        case .largeTitle:
            return "Font.largeTitle"
        case .title:
            return "Font.title"
        case .headline:
            return "Font.headline"
        case .subheadline:
            return "Font.subheadline"
        case .callout:
            return "Font.callout"
        case .body:
            return "Font.body"
        case .footnote:
            return "Font.footnote"
        case .caption:
            return "Font.caption"
        default:
            return "Font.unknown"
        }
    }
}
