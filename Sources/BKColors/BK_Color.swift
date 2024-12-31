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
        bk_red: Int = 255,
        bk_green: Int = 255,
        bk_blue: Int = 255,
        bk_alpha: Double = 1
    ) {
        self.init(
            bk_red: Double(bk_red) / 255.0,
            bk_green: Double(bk_green) / 255.0,
            bk_blue: Double(bk_blue) / 255.0,
            bk_alpha: bk_alpha
        )
    }
    
    public init(_ bk_hex: Int, bk_alpha: Double = 1) {
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

extension BK_Color {
    public static var bk_black: BK_Color { BK_Color(0x000000) }
    
    public static var bk_white: BK_Color { BK_Color(0xFFFFFF) }
    
    public static var bk_red: BK_Color { BK_Color(0xFF0000) }
    
    public static var bk_green: BK_Color { BK_Color(0x00FF00) }
    
    public static var bk_blue: BK_Color { BK_Color(0x0000FF) }
    
    public static var bk_yellow: BK_Color { BK_Color(0xFFFF00) }
    
    public static var bk_cyan: BK_Color { BK_Color(0x00FFFF) }
    
    public static var bk_magenta: BK_Color { BK_Color(0xFF00FF) }
    
    public static var bk_orange: BK_Color { BK_Color(0xFFA500) }
    
    public static var bk_purple: BK_Color { BK_Color(0x800080) }
    
    public static var bk_brown: BK_Color { BK_Color(0xA52A2A) }
    
    public static var bk_clear: BK_Color { BK_Color(0x000000, bk_alpha: 0) }
    
    public static var bk_gray: BK_Color { BK_Color(0x808080) }
    
    public static var bk_darkGray: BK_Color { BK_Color(0xA9A9A9) }
    
    public static var bk_lightGray: BK_Color { BK_Color(0xD3D3D3) }
    
    public static func bk_rgb(
        _ bk_red: Int,
        _ bk_green: Int,
        _ bk_blue: Int
    ) -> BK_Color {
        BK_Color(
            bk_red: bk_red,
            bk_green: bk_green,
            bk_blue: bk_blue
        )
    }
}
