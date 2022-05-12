//
//  CountryViewController.swift
//  Sports
//
//  Created by Doaa Essam on 5/2/22.
//  Copyright © 2022 iti. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController , UITableViewDataSource,UITableViewDelegate{
    var countryArray = ["Egypt","Spain","England"]
    var countryArrayImage = ["eg","sp","en"]
    var strSport : String?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false

      

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CountryTableViewCell.self), for: indexPath) as? CountryTableViewCell else {fatalError()}
        
        setupCell(cell, indexPath)


        return cell
    }
    private func setupCell(_ cell: CountryTableViewCell, _ indexPath: IndexPath) {
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 4
        cell.clipsToBounds = true
        cell.countyrName.text = countryArray [indexPath.row]
        cell.countryImage?.image = UIImage(named: countryArrayImage[indexPath.row])

        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
        return tableView.frame.height / 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let leagueViewController = storyboard?.instantiateViewController(identifier: "LeagueViewController") as! LeagueViewController
        leagueViewController.strSport = strSport
        leagueViewController.countryName = countryArray[indexPath.row]

        self.navigationController?.pushViewController(leagueViewController, animated: true)
       
        
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
