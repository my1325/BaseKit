//
//  BK_Color.swift
//  ColorTools
//
//  Created by mayong on 2024/12/10.
//

import Foundation
import UIKit

public struct BK_Color: Sendable {
    let bk_red: Double
    let bk_green: Double
    let bk_blue: Double
    let bk_alpha: Double
    
    public init(
        bk_red: Double = 1,
        bk_green: Double = 1,
        bk_blue: Double = 1,
        bk_alpha: Double = 1
    ) {
        self.bk_red = bk_red
        self.bk_green = bk_green
        self.bk_blue = bk_blue
        self.bk_alpha = bk_alpha
    }
    
    public init(
        bk_red: UInt = 255,
        bk_green: UInt = 255,
        bk_blue: UInt = 255,
        bk_alpha: Double = 1
    ) {
        self.init(
            bk_red: Double(bk_red) / 255.0,
            bk_green: Double(bk_green) / 255.0,
            bk_blue: Double(bk_blue) / 255.0,
            bk_alpha: bk_alpha
        )
    }
    
    public init(_ bk_hex: UInt, bk_alpha: Double = 1) {
        let bk_red = (bk_hex >> 16) & 0xFF
        let bk_green = (bk_hex >> 8) & 0xFF
        let bk_blue = bk_hex & 0xFF
        self.init(
            bk_red: bk_red,
            bk_green: bk_green,
            bk_blue: bk_blue,
            bk_alpha: bk_alpha
        )
    }
}

public extension BK_Color {
    var bk_uiColor: UIColor {
        .init(
            red: CGFloat(bk_red),
            green: CGFloat(bk_green),
            blue: CGFloat(bk_blue),
            alpha: CGFloat(bk_alpha)
        )
    }
}

#if canImport(SwiftUI)
import SwiftUI
public extension BK_Color {
    var bk_swiftUIColor: Color {
        Color(
            red: bk_red,
            green: bk_green,
            blue: bk_blue,
            opacity: bk_alpha
        )
    }
}
#endif
