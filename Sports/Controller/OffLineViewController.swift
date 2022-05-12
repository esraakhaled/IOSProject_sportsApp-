//
//  OffLineViewController.swift
//  Sports
//
//  Created by Doaa Essam on 5/3/22.
//  Copyright © 2022 iti. All rights reserved.
//

import UIKit

class OffLineViewController: UIViewController {
    let network = NetworkManager.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If the network is reachable show the main controller
        network.reachability.whenReachable = { _ in
            self.showMainController()
            }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }

    private func showMainController() -> Void {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "backOnLine", sender: self)
        
        }
    
    }}

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


