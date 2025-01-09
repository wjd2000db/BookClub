// FILE : DeviceInfo.swift
// PROJECT : PROG2030-Assignment #3 - BookClub
// PROGRAMMER : Yujin Jeong, Yujung Park
// FIRST VERSION : 2024-11-28
// DESCRIPTION : Provides utility functions to retrieve and display information about the user's device. 

import Foundation


import UIKit

func printDeviceInfo() {
    let device = UIDevice.current
    print("Device Name: \(device.name)")
    print("Device Model: \(device.model)")
    print("System Name: \(device.systemName)")
    print("System Version: \(device.systemVersion)")
    print("Identifier for Vendor: \(device.identifierForVendor?.uuidString ?? "N/A")")
}


func printBatteryInfo() {
    let device = UIDevice.current
    device.isBatteryMonitoringEnabled = true
    
    print("Battery Level: \(device.batteryLevel * 100)%")
    switch device.batteryState {
    case .unknown:
        print("Battery State: Unknown")
    case .unplugged:
        print("Battery State: Unplugged")
    case .charging:
        print("Battery State: Charging")
    case .full:
        print("Battery State: Full")
    @unknown default:
        print("Battery State: Unknown")
    }
}


func printStorageInfo() {
    if let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()) {
        let freeSize = systemAttributes[.systemFreeSize] as? Int64 ?? 0
        let totalSize = systemAttributes[.systemSize] as? Int64 ?? 0
        
        print("Total Storage: \(ByteCountFormatter.string(fromByteCount: totalSize, countStyle: .file))")
        print("Available Storage: \(ByteCountFormatter.string(fromByteCount: freeSize, countStyle: .file))")
    }
}


import Network

func printNetworkInfo() {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue.global(qos: .background)
    monitor.start(queue: queue)
    
    monitor.pathUpdateHandler = { path in
        if path.status == .satisfied {
            print("Network Status: Connected")
            if path.usesInterfaceType(.wifi) {
                print("Connection Type: Wi-Fi")
            } else if path.usesInterfaceType(.cellular) {
                print("Connection Type: Cellular")
            } else if path.usesInterfaceType(.wiredEthernet) {
                print("Connection Type: Ethernet")
            }
        } else {
            print("Network Status: Not Connected")
        }
        monitor.cancel()
    }
}
