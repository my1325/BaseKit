//
//  File.swift
//  BaseKit
//
//  Created by mayong on 2024/12/11.
//

import Foundation
import UIKit

public protocol BK_ImageCompatible {
    var bk_image: BK_Image { get }
}

extension BK_Image: BK_ImageCompatible {
    public var bk_image: BK_Image { self }
}

extension String: BK_ImageCompatible {
    public var bk_image: BK_Image {
        BK_Image.bk_assets(self)
    }
}

extension UIImage: BK_ImageCompatible {
    public var bk_image: BK_Image {
        BK_Image.bk_image(self)
    }
}

#if canImport(Colors)
import Colors
#endif

extension BK_ImageCompatible where Self: BK_ColorCompatible {
    public var bk_image: BK_Image {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: 1, height: 1),
            false,
            1
        )
        
        defer { UIGraphicsEndImageContext() }

        let bk_context = UIGraphicsGetCurrentContext()
        bk_context?.setFillColor(bk_color.bk_uiColor.cgColor)
        bk_context?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))

        let bk_image = UIGraphicsGetImageFromCurrentImageContext()
        return .bk_image(bk_image ?? UIImage())
    }
}

extension UInt: BK_ImageCompatible { }
extension BK_Color: BK_ImageCompatible { }
extension UIColor: BK_ImageCompatible { }

extension Array: BK_ImageCompatible where Element: BK_ColorCompatible {
    public var bk_image: BK_Image {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: 1, height: 1),
            false,
            1
        )
        
        defer { UIGraphicsEndImageContext() }

        let bk_context = UIGraphicsGetCurrentContext()
        let bk_colorSpace = CGColorSpaceCreateDeviceRGB()
        let bk_colors = self.map(\.bk_color.bk_uiColor.cgColor)
        let bk_gradient = CGGradient(
            colorsSpace: bk_colorSpace,
            colors: bk_colors as CFArray,
            locations: [0, 1]
        )!
        bk_context?.drawLinearGradient(
            bk_gradient,
            start: CGPoint(x: 1, y: 0),
            end: CGPoint(x: 1, y: 1),
            options: .drawsAfterEndLocation
        )
        let bk_image = UIGraphicsGetImageFromCurrentImageContext()
        return .bk_image(bk_image ?? UIImage())
    }
}

public extension UIImageView {
    var bk_image: BK_ImageCompatible? {
        get { image?.bk_image }
        set { image = newValue?.bk_image.bk_uiImage }
    }
    
    var bk_highlightedImage: BK_ImageCompatible? {
        get { highlightedImage?.bk_image }
        set { highlightedImage = newValue?.bk_image.bk_uiImage }
    }
    
    var bk_animationImages: [BK_ImageCompatible]? {
        get { animationImages?.map(\.bk_image) }
        set { animationImages = newValue?.compactMap(\.bk_image.bk_uiImage) }
    }
    
    var bk_highlightedAnimationImages: [BK_ImageCompatible]? {
        get { highlightedAnimationImages?.map(\.bk_image) }
        set { highlightedAnimationImages = newValue?.compactMap(\.bk_image.bk_uiImage) }
    }
}

public extension UIButton {
    func bk_setImage(_ bk_image: BK_ImageCompatible?, for state: UIControl.State) {
        setImage(bk_image?.bk_image.bk_uiImage, for: state)
    }
    
    func bk_setBackgroundImage(_ bk_image: BK_ImageCompatible?, for state: UIControl.State) {
        setBackgroundImage(bk_image?.bk_image.bk_uiImage, for: state)
    }
    
    func bk_image(for state: UIControl.State) -> BK_ImageCompatible? {
        image(for: state)?.bk_image
    }
    
    func bk_backgroundImage(for state: UIControl.State) -> BK_ImageCompatible? {
        backgroundImage(for: state)?.bk_image
    }
}

public extension UISwitch {
    var bk_onImage: BK_ImageCompatible? {
        get { onImage?.bk_image }
        set { onImage = newValue?.bk_image.bk_uiImage }
    }
    
    var bk_offImage: BK_ImageCompatible? {
        get { offImage?.bk_image }
        set { offImage = newValue?.bk_image.bk_uiImage }
    }
}

public extension UIProgressView {
    var bk_progressImage: BK_ImageCompatible? {
        get { progressImage?.bk_image }
        set { progressImage = newValue?.bk_image.bk_uiImage }
    }
    
    var bk_trackImage: BK_ImageCompatible? {
        get { trackImage?.bk_image }
        set { trackImage = newValue?.bk_image.bk_uiImage }
    }
}

#if canImport(SwiftUI)
import SwiftUI

public extension View {
    func bk_background(_ bk_image: BK_ImageCompatible?) -> some View {
        background(bk_image?.bk_image.bk_swiftUIImage)
    }
    
    func bk_overlay(_ bk_image: BK_ImageCompatible?) -> some View {
        overlay(bk_image?.bk_image.bk_swiftUIImage)
    }
    
    func bk_mask(_ bk_image: BK_ImageCompatible?) -> some View {
        mask(bk_image?.bk_image.bk_swiftUIImage)
    }
}

public extension Image {
    init(_ bk_image: BK_ImageCompatible) {
        self = bk_image.bk_image.bk_swiftUIImage
    }
}

#endif
