//
//  BK_ColorCompatible.swift
//  ColorTools
//
//  Created by mayong on 2024/12/10.
//

import UIKit

public protocol BK_ColorCompatible {
    var bk_color: BK_Color { get }
}

extension BK_Color: BK_ColorCompatible {
    public var bk_color: BK_Color { self }
}

extension UInt: BK_ColorCompatible {
    public var bk_color: BK_Color {
        BK_Color(self)
    }
}

extension UIColor: BK_ColorCompatible {
    public var bk_color: BK_Color {
        var bk_red: CGFloat = 0
        var bk_green: CGFloat = 0
        var bk_blue: CGFloat = 0
        var bk_alpha: CGFloat = 0
        getRed(&bk_red, green: &bk_green, blue: &bk_blue, alpha: &bk_alpha)
        return BK_Color(
            bk_red: Double(bk_red),
            bk_green: Double(bk_green),
            bk_blue: Double(bk_blue),
            bk_alpha: Double(bk_alpha)
        )
    }
}

public extension UIView {
    var bk_backgroundColor: BK_ColorCompatible? {
        get { backgroundColor?.bk_color  }
        set { backgroundColor = newValue?.bk_color.bk_uiColor }
    }
    
    var bk_tintColor: BK_ColorCompatible? {
        get { tintColor.bk_color }
        set { tintColor = newValue?.bk_color.bk_uiColor }
    }
}

public extension UIButton {
    func bk_setTitleColor(_ bk_color: BK_ColorCompatible, for state: UIControl.State) {
        setTitleColor(bk_color.bk_color.bk_uiColor, for: state)
    }
}

public extension UILabel {
    var bk_textColor: BK_ColorCompatible {
        get { textColor.bk_color }
        set { textColor = newValue.bk_color.bk_uiColor }
    }
}

public extension UITextField {
    var bk_textColor: BK_ColorCompatible? {
        get { textColor?.bk_color }
        set { textColor = newValue?.bk_color.bk_uiColor }
    }
}

public extension UITextView {
    var bk_textColor: BK_ColorCompatible? {
        get { textColor?.bk_color }
        set { textColor = newValue?.bk_color.bk_uiColor }
    }
}

public extension UIProgressView {
    var bk_progressTintColor: BK_ColorCompatible? {
        get { progressTintColor?.bk_color }
        set { progressTintColor = newValue?.bk_color.bk_uiColor }
    }
    
    var bk_trackTintColor: BK_ColorCompatible? {
        get { trackTintColor?.bk_color }
        set { trackTintColor = newValue?.bk_color.bk_uiColor }
    }
}

public extension UISwitch {
    var bk_onTintColor: BK_ColorCompatible? {
        get { onTintColor?.bk_color }
        set { onTintColor = newValue?.bk_color.bk_uiColor }
    }
    
    var bk_thumbTintColor: BK_ColorCompatible? {
        get { thumbTintColor?.bk_color }
        set { thumbTintColor = newValue?.bk_color.bk_uiColor }
    }
}

public extension UITableView {
    var bk_separatorColor: BK_ColorCompatible? {
        get { separatorColor?.bk_color }
        set { separatorColor = newValue?.bk_color.bk_uiColor }
    }
    
    var bk_sectionIndexColor: BK_ColorCompatible? {
        get { sectionIndexColor?.bk_color }
        set { sectionIndexColor = newValue?.bk_color.bk_uiColor }
    }
    
    var bk_sectionIndexBackgroundColor: BK_ColorCompatible? {
        get { sectionIndexBackgroundColor?.bk_color }
        set { sectionIndexBackgroundColor = newValue?.bk_color.bk_uiColor }
    }
    
    var bk_sectionIndexTrackingBackgroundColor: BK_ColorCompatible? {
        get { sectionIndexTrackingBackgroundColor?.bk_color }
        set { sectionIndexTrackingBackgroundColor = newValue?.bk_color.bk_uiColor }
    }
}

#if canImport(SwiftUI)
import SwiftUI

@available(iOS 14.0, *)
extension Color: BK_ColorCompatible {
    public var bk_color: BK_Color {
        let bk_uiColor = UIColor(self)
        return bk_uiColor.bk_color
    }
}

public extension View {
    func bk_backgroundColor(_ bk_color: BK_ColorCompatible) -> some View {
        background(bk_color.bk_color.bk_swiftUIColor)
    }
    
    func bk_foregroundColor(_ bk_color: BK_ColorCompatible) -> some View {
        foregroundColor(bk_color.bk_color.bk_swiftUIColor)
    }
    
    func bk_accentColor(_ bk_color: BK_ColorCompatible) -> some View {
        accentColor(bk_color.bk_color.bk_swiftUIColor)
    }
    
    func bk_shadow(
        bk_color: BK_ColorCompatible,
        bk_radius: CGFloat,
        bk_x: CGFloat,
        bk_y: CGFloat
    ) -> some View {
        shadow(
            color: bk_color.bk_color.bk_swiftUIColor,
            radius: bk_radius,
            x: bk_x,
            y: bk_y
        )
    }
    
    func bk_border(
        bk_color: BK_ColorCompatible,
        bk_width: CGFloat
    ) -> some View {
        border(bk_color.bk_color.bk_swiftUIColor, width: bk_width)
    }
    
    func bk_overlay(
        bk_color: BK_ColorCompatible,
        bk_alignment: Alignment = .center
    ) -> some View {
        overlay(bk_color.bk_color.bk_swiftUIColor, alignment: bk_alignment)
    }
}

public extension Shape {
    func bk_stroke(
        bk_color: BK_ColorCompatible,
        bk_lineWidth: CGFloat
    ) -> some View {
        stroke(bk_color.bk_color.bk_swiftUIColor, lineWidth: bk_lineWidth)
    }
    
    func bk_fill(
        bk_color: BK_ColorCompatible
    ) -> some View {
        fill(bk_color.bk_color.bk_swiftUIColor)
    }
}

#endif

extension BK_ColorCompatible {
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
        _ bk_red: UInt,
        _ bk_green: UInt,
        _ bk_blue: UInt
    ) -> BK_Color {
        BK_Color(
            bk_red: bk_red,
            bk_green: bk_green,
            bk_blue: bk_blue
        )
    }
}
