//
//  LancherViewController.swift
//  Sports
//
//  Created by Doaa Essam on 5/3/22.
//  Copyright © 2022 iti. All rights reserved.
//

import UIKit

class LancherViewController: UIViewController {
    let network: NetworkManager = NetworkManager.sharedInstance
    override func viewDidLoad() {
        print("dodod")
        super.viewDidLoad()

        
        
        if network.currentReachabilityStatus == .notReachable {
            self.showOfflinePage()
        }
        else{
            self.showMainPage()
        }

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func showMainPage() -> Void {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "sportController",sender: self)
            
        }
        
    }
    
private func showOfflinePage() -> Void {
    DispatchQueue.main.async {
        self.performSegue(withIdentifier: "NetworkUnavailable",sender: self)
    }    }
    
    
    
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


