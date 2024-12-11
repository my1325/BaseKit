//
//  File.swift
//  BaseKit
//
//  Created by mayong on 2024/12/11.
//

import Foundation
import UIKit

#if canImport(Colors)
import Colors
#endif

#if canImport(Images)
import Images
#endif

public enum BK_AttributedStringItem {
    case bk_font(UIFont)
    case bk_foregroundColor(BK_ColorCompatible)
    case bk_strikethroughStyle(NSUnderlineStyle)
    case bk_strikethroughColor(BK_ColorCompatible)
    case bk_paragraphStyle(NSParagraphStyle)
    case bk_backgroundColor(BK_ColorCompatible)
//    NSNumber containing integer, default 1: default ligatures, 0: no ligatures
    case bk_ligature(Int)
    //   NSNumber containing floating point value, in points; amount to modify default kerning. 0 means kerning is disabled.
    case bk_kern(Double)
    // NSNumber containing floating point value, in points; amount to modify default tracking. 0 means tracking is disabled.
    case bk_tracking(Double)
    case bk_underlineStyle(NSUnderlineStyle)
    case bk_strokeColor(BK_ColorCompatible)
    case bk_strokeWidth(Double)
    case bk_shadow(NSShadow)
    case bk_textEffect(String)
    case bk_attachment(NSTextAttachment)
    case bk_link(String)
    case bk_baselineOffset(Double)
    case bk_underlineColor(BK_ColorCompatible)
    case bk_writingDirection(NSWritingDirection)

    public var attributes: [NSAttributedString.Key: Any] {
        switch self {
        case let .bk_font(font): return [.font: font]
        case let .bk_foregroundColor(color): return [.foregroundColor: color.bk_color.bk_uiColor]
        case let .bk_strikethroughStyle(style): return [.strikethroughStyle: style.rawValue]
        case let .bk_strikethroughColor(color): return [.strikethroughColor: color.bk_color.bk_uiColor]
        case let .bk_paragraphStyle(paragraph): return [.paragraphStyle: paragraph]
        case let .bk_backgroundColor(color): return [.backgroundColor: color.bk_color.bk_uiColor]
        case let .bk_ligature(ligature): return [.ligature: ligature]
        case let .bk_kern(kern): return [.kern: kern]
        case let .bk_tracking(tracking):
            if #available(iOS 14.0, *) {
                return [.tracking: tracking]
            } else {
                return [:]
            }
        case let .bk_underlineStyle(underline): return [.underlineStyle: underline.rawValue]
        case let .bk_strokeColor(color): return [.strokeColor: color.bk_color.bk_uiColor]
        case let .bk_strokeWidth(width): return [.strokeWidth: width]
        case let .bk_shadow(shadow): return [.shadow: shadow]
        case let .bk_textEffect(effect): return [.textEffect: effect]
        case let .bk_attachment(attachment): return [.attachment: attachment]
        case let .bk_link(link): return [.link: link]
        case let .bk_baselineOffset(offset): return [.baselineOffset: offset]
        case let .bk_underlineColor(color): return [.underlineColor: color.bk_color.bk_uiColor]
        case let .bk_writingDirection(direction): return [.writingDirection: direction.rawValue]
        }
    }
}

public extension Array where Element == BK_AttributedStringItem {
    var bk_attributes: [NSAttributedString.Key: Any] {
        reduce([:]) { $0.merging($1.attributes, uniquingKeysWith: { $1 }) }
    }
}

extension NSAttributedString {
    public convenience init(
        _ bk_string: String,
        bk_attributes: [BK_AttributedStringItem] = []
    ) {
        self.init(string: bk_string, attributes: bk_attributes.bk_attributes)
    }
}

extension NSMutableAttributedString {
    func bk_addAttribute(
        _ bk_attributes: [BK_AttributedStringItem],
        bk_range: NSRange? = nil
    ) {
        if let bk_range {
            addAttributes(
                bk_attributes.bk_attributes,
                range: bk_range
            )
        } else {
            addAttributes(
                bk_attributes.bk_attributes,
                range: NSMakeRange(0, self.length)
            )
        }
    }
}

