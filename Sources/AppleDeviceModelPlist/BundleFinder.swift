// BundleFinder.swift
// Copyright © VTB. All rights reserved.

import Foundation

private class BundleFinder {}

public extension Bundle {
    static var resourceBundle: Bundle = {
 
        let bundleName = "AppleDeviceModelPlist_AppleDeviceModelPlist"
        let candidates = [
            Bundle.main.resourceURL,
            Bundle(for: BundleFinder.self).resourceURL,
            Bundle.main.bundleURL,
            Bundle(for: BundleFinder.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent(),
        ]
        for candidate in candidates {
            let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        fatalError("unable to find bundle named \(bundleName)")
    }()
}
