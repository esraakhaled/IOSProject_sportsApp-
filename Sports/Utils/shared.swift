//
//  shared.swift
//  Sports
//
//  Created by Doaa Essam on 5/2/22.
//  Copyright © 2022 iti. All rights reserved.
//

import Foundation
import Reachability
import SwiftMessages

class shared {
    
//   static var isConncted = true
//    static let reachability = try! Reachability()
//
//   static  func reachabilityStatus() -> Bool{
//
//        reachability.whenReachable = { reachability in
//            print("reach")
//            if reachability.connection == .wifi {
//                print("tru")
//                isConncted = true
//
//            } else if reachability.connection == .cellular {
//                print(true)
//                isConncted = true
//
//            }
//
//        }
//        reachability.whenUnreachable = { _ in
//            print("un")
//            isConncted = false
//        }
//
//
//      return isConncted
//    }
//
//    static func checkConnectivity(context : AnyObject ) -> Bool {
//
//
//        if reachabilityStatus() == true{
//            return true
//        } else {
//       alertWithAction("Please Check Your Internet Connection", Title: "Error", BtnOk: "ok", Context: context) { () -> Void? in
//
//               print("bbbbb")            }
//
//            return false
//        }
//    }
    
    
    static func alertWithAction(_ Message:String?,Title:String?,BtnOk:String?,Context:AnyObject ,Actions:@escaping ()->Void?){
        let WrongAlert=UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
        WrongAlert.addAction(UIAlertAction(title: BtnOk, style: UIAlertAction.Style.default, handler: { Action in
            Actions()
        }))
        Context.present(WrongAlert, animated: true, completion: nil)
    }
   static func showSwiftMessage(title: String = "", message: String = "", theme: Theme = .error) {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(theme)
        view.configureDropShadow()
        view.button?.isHidden = true
        view.configureContent(title: title, body: message)
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10
        SwiftMessages.show(view: view)
        
    }
    
}
