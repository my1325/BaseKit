//
//  BK_Permissions.swift
//  BaseKit
//
//  Created by mayong on 2024/12/16.
//

import AppTrackingTransparency
import AVFoundation
import Foundation
import Photos

public enum BK_AuthorizationOrigin: Sendable {
    case bk_photoLibrary
    case bk_microphone
    case bk_camera
    case bk_appTracking
}

public enum BK_AuthorizationStatus: Sendable {
    case bk_notDetermined
    case bk_denied
    case bk_authorized
    
    public var bk_isAuthorized: Bool {
        self == .bk_authorized
    }
}

public final class BK_Permisions {
    fileprivate static func bk_requestAvDeviceType(
        _ bk_avDeviceType: AVMediaType
    ) async -> BK_AuthorizationStatus {
        if await AVCaptureDevice.requestAccess(for: bk_avDeviceType) {
            return .bk_authorized
        }
        return .bk_denied
    }
    
    fileprivate static func bk_authorizationForPhotoLibrary() -> BK_AuthorizationStatus {
        if #available(iOS 14, *) {
            return bk_photoLibraryAuthorization(PHPhotoLibrary.authorizationStatus(for: .readWrite))
        } else {
            return bk_photoLibraryAuthorization(PHPhotoLibrary.authorizationStatus())
        }
    }
    
    fileprivate static func bk_authorization(
        _ bk_origin: BK_AuthorizationOrigin
    ) -> BK_AuthorizationStatus {
        switch bk_origin {
        case .bk_appTracking:
            if #available(iOS 14.5, *) {
                return bk_authorizationForAppTracking()
            } else {
                return .bk_denied
            }
        case .bk_camera:
            return bk_authroizationForAvDevice(.video)
        case .bk_microphone:
            return bk_authroizationForAvDevice(.audio)
        case .bk_photoLibrary:
            return bk_authorizationForPhotoLibrary()
        }
    }

    public static func bk_requestAuthorization(
        _ bk_origin: BK_AuthorizationOrigin
    ) async -> BK_AuthorizationStatus {
        switch bk_origin {
        case .bk_appTracking:
            if #available(iOS 14.5, *) {
                return await bk_requestAppTracking()
            } else {
                return .bk_authorized
            }
        case .bk_camera:
            return await bk_requestAvDeviceType(.video)
        case .bk_microphone:
            return await bk_requestAvDeviceType(.audio)
        case .bk_photoLibrary:
            return await bk_requestPhotorLibrary()
        }
    }
    
    @available(iOS 14.5, *)
    fileprivate static func bk_requestAppTracking() async -> BK_AuthorizationStatus {
        let bk_status: BK_AuthorizationStatus
        switch await ATTrackingManager.requestTrackingAuthorization() {
        case .authorized: bk_status = .bk_authorized
        case .denied, .restricted: bk_status = .bk_denied
        case .notDetermined: bk_status = .bk_notDetermined
        @unknown default:
            bk_status = .bk_denied
        }
        return bk_status
    }
    
    fileprivate static func bk_authroizationForAvDevice(
        _ bk_avDeviceType: AVMediaType
    ) -> BK_AuthorizationStatus {
        switch AVCaptureDevice.authorizationStatus(for: bk_avDeviceType) {
        case .notDetermined: return .bk_notDetermined
        case .authorized: return .bk_authorized
        case .restricted, .denied: return .bk_denied
        @unknown default: return .bk_denied
        }
    }

    fileprivate static func bk_requestPhotorLibrary() async -> BK_AuthorizationStatus {
        if #available(iOS 14, *) {
            let bk_status = await PHPhotoLibrary.requestAuthorization(for: .readWrite)
            return bk_photoLibraryAuthorization(bk_status)
        } else {
            return await withUnsafeContinuation { bk_continuation in
                PHPhotoLibrary.requestAuthorization {
                    bk_continuation.resume(returning: self.bk_photoLibraryAuthorization($0))
                }
            }
        }
    }
    
    @available(iOS 14.5, *)
    fileprivate static func bk_authorizationForAppTracking() -> BK_AuthorizationStatus {
        switch ATTrackingManager.trackingAuthorizationStatus {
        case .authorized: return .bk_authorized
        case .restricted, .denied: return .bk_denied
        case .notDetermined: return .bk_notDetermined
        @unknown default: return .bk_denied
        }
    }
}

private extension BK_Permisions {
    static func bk_photoLibraryAuthorization(
        _ bk_originAuthorization: PHAuthorizationStatus
    ) -> BK_AuthorizationStatus {
        let bk_status: BK_AuthorizationStatus
        switch bk_originAuthorization {
        case .limited, .authorized: bk_status = .bk_authorized
        case .notDetermined: bk_status = .bk_notDetermined
        case .restricted, .denied: bk_status = .bk_denied
        @unknown default:
            bk_status = .bk_denied
        }
        return bk_status
    }
}
