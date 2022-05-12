//
//  SplashViewController.swift
//  Sports
//
//  Created by Esraa Khaled   on 04/05/2022.
//  Copyright © 2022 iti. All rights reserved.
//

import UIKit
import Lottie
class SplashViewController: UIViewController {
    @IBOutlet weak var animationView: UIImageView!
    let network: NetworkManager = NetworkManager.sharedInstance

   //let animationView = AnimationView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.animation()
        self.endSplash()
        
        
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
    func animation() -> Void {
           let animationView = AnimationView();
           animationView.animation = Animation.named("animation")
           animationView.contentMode = .scaleAspectFit
           animationView.frame = view.bounds
           animationView.loopMode = .loop
           view.addSubview(animationView)
           animationView.play()
       }
       
       func endSplash() {
           DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
               guard let self = self else
               {
                return}
            
            if self.network.currentReachabilityStatus == .notReachable {
                self.showOfflinePage()
            }
            else{
                self.showMainPage()
            }
            
           }
           
       }
    
}

