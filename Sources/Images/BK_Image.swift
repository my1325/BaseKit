//
//  File.swift
//  BaseKit
//
//  Created by mayong on 2024/12/11.
//

import Foundation
import UIKit

public enum BK_Image: Sendable {
    case bk_image(UIImage)
    case bk_data(Data)
    case bk_assets(String)
    case bk_inBundle(String, Bundle)
}

public extension BK_Image {
    var bk_uiImage: UIImage? {
        switch self {
        case let .bk_image(image):
            return image
        case let .bk_data(data):
            return UIImage(data: data)
        case let .bk_assets(name):
            return UIImage(named: name)
        case let .bk_inBundle(name, bundle):
            return UIImage(
                named: name,
                in: bundle,
                compatibleWith: nil
            )
        }
    }
}

#if canImport(SwiftUI)
import SwiftUI

public extension BK_Image {
    var bk_swiftUIImage: Image {
        switch self {
        case let .bk_image(bk_uIImage):
            return Image(uiImage: bk_uIImage)
        case let .bk_data(bk_data):
            return Image(uiImage: UIImage(data: bk_data) ?? UIImage())
        case let .bk_assets(bk_string):
            return Image(bk_string)
        case let .bk_inBundle(string, bundle):
            return Image(
                string,
                bundle: bundle
            )
        }
    }
}
#endif
