//
//  SportsCollectionViewController.swift
//  Sports
//
//  Created by Doaa Essam on 5/1/22.
//  Copyright © 2022 iti. All rights reserved.
//

import UIKit

import SDWebImage
class SportsCollectionViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
   // let numberOfCells = 9
        let kCellHeight : CGFloat = 130
    let kLineSpacing : CGFloat = 0
        let kInset : CGFloat = 0
    @IBOutlet weak var collevtionView: UICollectionView!
    var allSportsResult : [sportse]?

    override func viewDidLoad() {
        
        let network: NetworkManager = NetworkManager.sharedInstance

        super.viewDidLoad()
        
         allSportsResult = []
        let indecator = UIActivityIndicatorView(style:.large)
        indecator.center = self .view.center
        self.view.addSubview(indecator)
        indecator.startAnimating()
        self.navigationController?.isNavigationBarHidden = true


        ApiCall.getAllSports(context: self){[weak self ]
            (result ,error) in
            if result?.sports != nil {
            self?.allSportsResult? = result!.sports
            }
            else {
                
            }
            
            DispatchQueue .main.async {
                self?.collevtionView.reloadData()
                indecator.stopAnimating()
        
        
        
            }
              
        }
        
            network.reachability.whenUnreachable = { _ in
                shared.alertWithAction("Please Check Your Internet Connection", Title: "Error", BtnOk: "ok", Context: self) { () -> Void? in

                    print("no net")
                    //self.showOfflinePage()
                }
            }
  
    

        }
    private func showOfflinePage() -> Void {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "NetworkUnavailable",sender: self)
        }    }
    
    
    
}
    extension  SportsCollectionViewController {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allSportsResult!.count
    }
//    func numberOfSections(in collectionView: UICollectionView) -> Int{
//        return 2
//    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("hello")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sportsCell", for: indexPath)
                 as! SportsCollectionViewCell
                     cell.sportsName.text = allSportsResult?[indexPath.row].strSport
                       cell.sportsImage.sd_setImage(with: URL(string: allSportsResult![indexPath.row].strSportThumb!), completed: nil)
        
                     cell.sportsImage.contentMode = .scaleAspectFill
                      cell.clipsToBounds = true
                return cell
    }
    



        //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //            let widthPerItem = collectionView.bounds.width / 2 - 5
        //
        //        return CGSize(width: widthPerItem, height: 120)
        //
        //
        //
        //        }
        //
            
                
                 func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                    let countryViewController = storyboard?.instantiateViewController(identifier: "CountryViewController") as! CountryViewController
                    countryViewController.strSport = allSportsResult?[indexPath.row].strSport
                    self.navigationController?.pushViewController(countryViewController, animated: true)
                   
                
                }
          
                func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
                   {
                    let width = (self.collevtionView.frame.size.width - 18 ) / 2
                    let hight = (self.collevtionView.frame.size.height ) / 3

                   
                    return CGSize(width:width, height: hight)
           }

           func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
           {
               return kLineSpacing
           }

           func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
           {
               return UIEdgeInsets(top: kInset, left: kInset, bottom: kInset, right: kInset)
           }
       

        
}

