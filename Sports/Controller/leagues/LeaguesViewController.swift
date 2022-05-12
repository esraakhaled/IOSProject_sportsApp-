//
//  LeagueViewController.swift
//  Sports
//
//  Created by Esraa Khaled   on 04/05/2022.
//  Copyright © 2022 iti. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire
import Reachability
class LeagueViewController: UITableViewController {
    let reachability = try! Reachability()
    var networkIndicator :UIActivityIndicatorView!
    var res :[city] = []
    var strSport : String?
    var countryName : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        initActivityIndicator()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        //declare this property where it won't go out of scope relative to your listener
        networkIndicator.stopAnimating()
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                ApiCall.getAllLeagues(sportName : self.strSport ?? "Soccer",sportCountry: self.countryName ?? "England")
                 { (res, error)in
                    if let comingLeauges:[city] = res{
                        self.res = comingLeauges
                        print("count is \(self.res.count)")
                        print("ssssss")
                    }
                   // self?.res = result!.leagues
                   // print(result!.items[0].title)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                       
                    }
            }
            } else {
              
            }
        }
        reachability.whenUnreachable = { _ in
            print("Not reachable")
            let alert = UIAlertController(title: "Error", message: "There is no data to display", preferredStyle: .alert)
                   
                   let okAction  = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
                   }
                   
                   alert.addAction(okAction)
                   self.present(alert, animated: true, completion: nil)
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    func initActivityIndicator(){
            networkIndicator = UIActivityIndicatorView(style: .large)
            networkIndicator.center = view.center
            view.addSubview(networkIndicator)
            networkIndicator.startAnimating()
        }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return res.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaguesCell", for: indexPath) as! LeagueCustomCell
        let league = res[indexPath.row]
        cell.leaugeName.text = league.strLeague
       cell.youtubeBtn.isHidden = true
        cell.youtube = league.strYoutube

        if let imgStr = league.strBadge{
            cell.leagueImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.leagueImage.sd_setImage(with: URL(string: imgStr), placeholderImage: UIImage(named: "placeholder"))
        }
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.none)

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 63.0
    }
    
   
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return "Leagues"
    }
   
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let teamViewController = storyboard?.instantiateViewController(identifier: "LeagueDetailsViewController") as! LeagueDetailsViewController
    
    teamViewController.leagueName =  res[indexPath.row].strLeague
    teamViewController.leagueID = res[indexPath.row].idLeague
    teamViewController.league = res[indexPath.row]
    teamViewController.comeFrom = "d3d3"
        self.navigationController?.pushViewController(teamViewController, animated: true)
    }
 

  

}
