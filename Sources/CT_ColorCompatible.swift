//
//  CT_ColorCompatible.swift
//  ColorTools
//
//  Created by mayong on 2024/12/10.
//

import UIKit

public protocol CT_ColorCompatible {
    var ct_color: CT_Color { get }
}

extension CT_Color: CT_ColorCompatible {
    public var ct_color: CT_Color { self }
}

extension String: CT_ColorCompatible {
    public var ct_color: CT_Color {
        CT_Color(self)
    }
}

extension UInt: CT_ColorCompatible {
    public var ct_color: CT_Color {
        CT_Color(self)
    }
}

extension UIColor: CT_ColorCompatible {
    public var ct_color: CT_Color {
        var ct_red: CGFloat = 0
        var ct_green: CGFloat = 0
        var ct_blue: CGFloat = 0
        var ct_alpha: CGFloat = 0
        getRed(&ct_red, green: &ct_green, blue: &ct_blue, alpha: &ct_alpha)
        return CT_Color(
            ct_red: Double(ct_red),
            ct_green: Double(ct_green),
            ct_blue: Double(ct_blue),
            ct_alpha: Double(ct_alpha)
        )
    }
}

public extension UIView {
    var ct_backgroundColor: CT_ColorCompatible? {
        get { backgroundColor?.ct_color  }
        set { backgroundColor = newValue?.ct_color.ct_uiColor }
    }
    
    var ct_tintColor: CT_ColorCompatible? {
        get { tintColor.ct_color }
        set { tintColor = newValue?.ct_color.ct_uiColor }
    }
}

public extension UIButton {
    func ct_setTitleColor(_ ct_color: CT_ColorCompatible, for state: UIControl.State) {
        setTitleColor(ct_color.ct_color.ct_uiColor, for: state)
    }
}

public extension UILabel {
    var ct_textColor: CT_ColorCompatible {
        get { textColor.ct_color }
        set { textColor = newValue.ct_color.ct_uiColor }
    }
}

public extension UITextField {
    var ct_textColor: CT_ColorCompatible? {
        get { textColor?.ct_color }
        set { textColor = newValue?.ct_color.ct_uiColor }
    }
}

public extension UITextView {
    var ct_textColor: CT_ColorCompatible? {
        get { textColor?.ct_color }
        set { textColor = newValue?.ct_color.ct_uiColor }
    }
}

public extension UIProgressView {
    var ct_progressTintColor: CT_ColorCompatible? {
        get { progressTintColor?.ct_color }
        set { progressTintColor = newValue?.ct_color.ct_uiColor }
    }
    
    var ct_trackTintColor: CT_ColorCompatible? {
        get { trackTintColor?.ct_color }
        set { trackTintColor = newValue?.ct_color.ct_uiColor }
    }
}

public extension UISwitch {
    var ct_onTintColor: CT_ColorCompatible? {
        get { onTintColor?.ct_color }
        set { onTintColor = newValue?.ct_color.ct_uiColor }
    }
    
    var ct_thumbTintColor: CT_ColorCompatible? {
        get { thumbTintColor?.ct_color }
        set { thumbTintColor = newValue?.ct_color.ct_uiColor }
    }
}

public extension UITableView {
    var ct_separatorColor: CT_ColorCompatible? {
        get { separatorColor?.ct_color }
        set { separatorColor = newValue?.ct_color.ct_uiColor }
    }
    
    var ct_sectionIndexColor: CT_ColorCompatible? {
        get { sectionIndexColor?.ct_color }
        set { sectionIndexColor = newValue?.ct_color.ct_uiColor }
    }
    
    var ct_sectionIndexBackgroundColor: CT_ColorCompatible? {
        get { sectionIndexBackgroundColor?.ct_color }
        set { sectionIndexBackgroundColor = newValue?.ct_color.ct_uiColor }
    }
    
    var ct_sectionIndexTrackingBackgroundColor: CT_ColorCompatible? {
        get { sectionIndexTrackingBackgroundColor?.ct_color }
        set { sectionIndexTrackingBackgroundColor = newValue?.ct_color.ct_uiColor }
    }
}

#if canImport(SwiftUI)
import SwiftUI

@available(iOS 14.0, *)
extension Color: CT_ColorCompatible {
    public var ct_color: CT_Color {
        let ct_uiColor = UIColor(self)
        return ct_uiColor.ct_color
    }
}

public extension View {
    func ct_backgroundColor(_ ct_color: CT_ColorCompatible) -> some View {
        background(ct_color.ct_color.ct_swiftUIColor)
    }
    
    func ct_foregroundColor(_ ct_color: CT_ColorCompatible) -> some View {
        foregroundColor(ct_color.ct_color.ct_swiftUIColor)
    }
    
    func ct_accentColor(_ ct_color: CT_ColorCompatible) -> some View {
        accentColor(ct_color.ct_color.ct_swiftUIColor)
    }
    
    func ct_shadow(
        ct_color: CT_ColorCompatible,
        ct_radius: CGFloat,
        ct_x: CGFloat,
        ct_y: CGFloat
    ) -> some View {
        shadow(
            color: ct_color.ct_color.ct_swiftUIColor,
            radius: ct_radius,
            x: ct_x,
            y: ct_y
        )
    }
    
    func ct_border(
        ct_color: CT_ColorCompatible,
        ct_width: CGFloat
    ) -> some View {
        border(ct_color.ct_color.ct_swiftUIColor, width: ct_width)
    }
    
    func ct_overlay(
        ct_color: CT_ColorCompatible,
        ct_alignment: Alignment = .center
    ) -> some View {
        overlay(ct_color.ct_color.ct_swiftUIColor, alignment: ct_alignment)
    }
}

public extension Shape {
    func ct_stroke(
        ct_color: CT_ColorCompatible,
        ct_lineWidth: CGFloat
    ) -> some View {
        stroke(ct_color.ct_color.ct_swiftUIColor, lineWidth: ct_lineWidth)
    }
    
    func ct_fill(
        ct_color: CT_ColorCompatible
    ) -> some View {
        fill(ct_color.ct_color.ct_swiftUIColor)
    }
}

#endif
