//
//  CT_Color.swift
//  ColorTools
//
//  Created by mayong on 2024/12/10.
//

import Foundation
import UIKit

public struct CT_Color {
    let ct_red: Double
    let ct_green: Double
    let ct_blue: Double
    let ct_alpha: Double
    
    public init(
        ct_red: Double = 1,
        ct_green: Double = 1,
        ct_blue: Double = 1,
        ct_alpha: Double = 1
    ) {
        self.ct_red = ct_red
        self.ct_green = ct_green
        self.ct_blue = ct_blue
        self.ct_alpha = ct_alpha
    }
    
    public init(
        ct_red: UInt = 255,
        ct_green: UInt = 255,
        ct_blue: UInt = 255,
        ct_alpha: Double = 1
    ) {
        self.init(
            ct_red: Double(ct_red) / 255.0,
            ct_green: Double(ct_green) / 255.0,
            ct_blue: Double(ct_blue) / 255.0,
            ct_alpha: ct_alpha
        )
    }
    
    public init(_ ct_hex: UInt, ct_alpha: Double = 1) {
        let ct_red = (ct_hex >> 16) & 0xFF
        let ct_green = (ct_hex >> 8) & 0xFF
        let ct_blue = ct_hex & 0xFF
        self.init(
            ct_red: ct_red,
            ct_green: ct_green,
            ct_blue: ct_blue,
            ct_alpha: ct_alpha
        )
    }
    
    public init(_ ct_hexString: String, ct_alpha: Double = 1) {
        var ct_hex: Int64 = 0
        Scanner(string: ct_hexString)
            .scanHexInt64(&ct_hex)
        self.init(UInt(ct_hex), ct_alpha: ct_alpha)
    }
}

public extension CT_Color {
    var ct_uiColor: UIColor {
        .init(
            red: CGFloat(ct_red),
            green: CGFloat(ct_green),
            blue: CGFloat(ct_blue),
            alpha: CGFloat(ct_alpha)
        )
    }
}

#if canImport(SwiftUI)
import SwiftUI
public extension CT_Color {
    var ct_swiftUIColor: Color {
        Color(
            red: ct_red,
            green: ct_green,
            blue: ct_blue,
            opacity: ct_alpha
        )
    }
}
#endif
