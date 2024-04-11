//
//  Device.swift
//  Vollmed
//
//  Created by Matheus Cepil Alcatrao on 11/03/24.
//

import Foundation

struct Device {
    
    
    static func isSimulator() -> Bool {
        var isRunningOnSimulator: Bool {
#if targetEnvironment(simulator)
            return true
#else
            return false
#endif
        }
        return isRunningOnSimulator
    }
}
