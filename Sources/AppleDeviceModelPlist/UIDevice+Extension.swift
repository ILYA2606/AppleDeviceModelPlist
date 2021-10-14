// UIDevice+Extension.swift
// Copyright © VTB. All rights reserved.

import UIKit

public extension UIDevice {
    /// Model identifier (For example, iPhone10,3 or iPhone7,1)
    var modelIdentifier: String {
        #if targetEnvironment(simulator)
        let identifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "Simulator"
        #else
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        #endif
        return identifier
    }

    /// Name of the model in human-readable form (For example, iPhone 13 Pro Max). If the device is not in the Devices.plist list, it will return the model identifier
    var modelName: String {
        guard
            let path = Bundle.resourceBundle.path(forResource: "Devices", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path) as? [String: String],
            let name = dict[modelIdentifier]
        else { return modelIdentifier }
        return name
    }
}
