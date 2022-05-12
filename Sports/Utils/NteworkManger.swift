//
//  NteworkManger.swift
//  Sports
//
//  Created by Doaa Essam on 5/3/22.
//  Copyright © 2022 iti. All rights reserved.
//

import UIKit
import  Reachability
import SystemConfiguration
class NetworkManager: NSObject {
    var reachability: Reachability!

    static let sharedInstance: NetworkManager = {
        return NetworkManager()     }()


    
    override init() {
        super.init()
        reachability = try! Reachability()
        NotificationCenter.default.addObserver(  self, selector: #selector(networkStatusChanged(_:)),            name: .reachabilityChanged,object: reachability        )


        do {
            try reachability.startNotifier()
            
        } catch {
            print("Unable to start notifier")
            
        }    }
    
    @objc func networkStatusChanged(_ notification: Notification) {
        
        // Do something globally here!
        
    }
    
    static func stopNotifier() -> Void {
        do {
            try (NetworkManager.sharedInstance.reachability).startNotifier()
        } catch {
            print("Error stopping notifier")
        }
        
    }

    // Network isreachable

    static func isReachable(completed: @escaping (NetworkManager) -> Void) {        if (NetworkManager.sharedInstance.reachability.whenReachable) != nil {            completed(NetworkManager.sharedInstance)
            
          
        }
        
        }

    // Network is unreachable
    static func isUnreachable(completed: @escaping (NetworkManager) -> Void) {        if ((NetworkManager.sharedInstance.reachability.whenReachable) == nil) {            completed(NetworkManager.sharedInstance)        }
        
    }


    // Network is reachable via WWAN/Cellular
    static func isReachableViaWWAN(completed: @escaping (NetworkManager) -> Void) {        if (NetworkManager.sharedInstance.reachability).connection == .cellular {            completed(NetworkManager.sharedInstance)        }    }
    
    // Network is reachable via WiFi
    static func isReachableViaWiFi(completed: @escaping (NetworkManager) -> Void) {        if (NetworkManager.sharedInstance.reachability).connection == .wifi {            completed(NetworkManager.sharedInstance)        }    }

   
       static var isConncted = false
        static let reachability = try! Reachability()
    
       static  func reachabilityStatus() -> Bool{
    
            reachability.whenReachable = { reachability in
                
                if reachability.connection == .wifi {
                    isConncted = true
                    
    
                } else if reachability.connection == .cellular {
                    print(true)
                    isConncted = true
    
                }
    
            }
            reachability.whenUnreachable = { _ in
                isConncted = false
            }
    
    
          return isConncted
        }
    
    
    
    var isConnect = false

    func checkReachability() -> Bool{
        reachability.whenReachable = {  reachability in
            if reachability.connection == .wifi {
              
                self.isConnect = true
                print("wif")

            } else if reachability .connection == .cellular {
                self.isConnect = true
                print("cell")
            }
        }
        reachability.whenUnreachable = { _ in
            self.isConnect = false
            print("no")
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        print(self.isConnect)
return isConnect
    }
    
    
    
    
    
    
    enum ReachabilityStatus {
        case notReachable
        case reachableViaWWAN
        case reachableViaWiFi
    }

    var currentReachabilityStatus: ReachabilityStatus {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return .notReachable
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return .notReachable
        }
        
        if flags.contains(.reachable) == false {
            return .notReachable
        } else if flags.contains(.isWWAN) == true {
            return .reachableViaWWAN
        } else if flags.contains(.connectionRequired) == false {
           
            return .reachableViaWiFi
        } else if (flags.contains(.connectionOnDemand) == true || flags.contains(.connectionOnTraffic) == true) && flags.contains(.interventionRequired) == false {
            
            return .reachableViaWiFi
        } else {
            return .notReachable
        }
    }
    

    
}
