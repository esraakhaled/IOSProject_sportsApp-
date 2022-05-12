//
//  LeagueDetailsViewController.swift
//  Sports
//
//  Created by yasmeen hosny on 5/3/22.
//  Copyright © 2022 iti. All rights reserved.
//

import UIKit
import SDWebImage
import CoreData


class LeagueDetailsViewController: UIViewController, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var fav_btn: UIButton!
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    @IBOutlet weak var upcomingEventsCollectionView: UICollectionView!
    @IBOutlet weak var latestResultCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var teams: [Team] = []
    var upcomingEvents: [UpcomingEvent] = []
    var latestResult: [LatestResult] = []
    var clicked = true
    var comeFrom : String? = nil
    
    var leagueName: String? = nil
    var leagueID: String? = nil
    var league :city? 
    var appdelegate:AppDelegate?
    var managedContext:NSManagedObjectContext?
    var entity:NSEntityDescription?
    
    var leagueArray:[League] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appdelegate=UIApplication.shared.delegate as? AppDelegate
        managedContext=appdelegate?.persistentContainer.viewContext
        entity=NSEntityDescription.entity(forEntityName: "FavoriteLeage", in: managedContext!)
        // Do any additional setup after loading the view.
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 500)

        if comeFrom == "fav" {
            fav_btn.setBackgroundImage(UIImage(systemName: "heart.fill"), for: UIControl.State.normal)

        
        }
        getTeamData()
        getEventsAndResultsData()
    }
    
    
    @IBAction func btn_fav(_ sender: Any) {
        if comeFrom == "d3d3"{
        if clicked {
        let url = URL(string: (self.league?.strBadge)!)
        var data : Data?
        DispatchQueue.global().async { [self] in
             data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            
        
        let league = NSManagedObject(entity: entity!, insertInto: managedContext!)
        league.setValue(self.league?.idLeague, forKey: "id")
        league.setValue(self.league?.strYoutube, forKey: "youtube")
        league.setValue(data, forKey: "image")
        league.setValue(leagueName, forKey: "league")
               do{
              try managedContext?.save()
                
               }catch let error as NSError{
                   print(error)
               }
            clicked=false
        }
            fav_btn.setBackgroundImage(UIImage(systemName: "heart.fill"), for: UIControl.State.normal)

        
    }
            
        }
    }
    func getTeamData(){
        guard let paramter = self.leagueName else {
            print("There are no parameters for teams")
            return
        }
        
           ApiCall.getTeamsForLeague(leagueName: paramter) { (data, error) in
               if let resultTeams: [Team] = data{
                   self.teams = resultTeams
               }
               DispatchQueue.main.async {
                   self.teamsCollectionView.reloadData()
               }
            }
    }
    
    
    func getEventsAndResultsData(){
        guard let parameter = self.leagueID else {
           print("There are no parameters for events")
           return
        }
            ApiCall.getUpcomingEvents(leagueID: parameter) { (data, error) in
                guard let data = data else {
                    return
                }
                    guard let events = data.events else {return}
                   self.upcomingEvents = events
                
                DispatchQueue.main.async {
                    self.upcomingEventsCollectionView.reloadData()
                }
            }
            
            ApiCall.getLatestResults(leagueID: parameter) { (data, error) in
                guard let data = data else {
                    return
                }
                    guard let events = data.events else {return}
                   self.latestResult = events
                
                DispatchQueue.main.async {
                    self.latestResultCollectionView.reloadData()
                }
            }
    }
}


extension LeagueDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var rows: Int = 0
        
        switch collectionView {
        case teamsCollectionView:
            rows = self.teams.count
        case upcomingEventsCollectionView:
            rows = self.upcomingEvents.count
        case latestResultCollectionView:
            rows = self.latestResult.count
        default:
            rows = 0
        }
        return rows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell?
        
        switch collectionView {
            case teamsCollectionView:
                cell = customTeamCell(collectionView: collectionView, indexPath: indexPath)
            case upcomingEventsCollectionView:
                cell = customUpcomingEventCell(collectionView: collectionView, indexPath: indexPath)
            case latestResultCollectionView:
                cell = customLastReaultCell(collectionView: collectionView, indexPath: indexPath)
            default:
                cell = nil
        }
        
        cell!.layer.borderColor = UIColor.black.cgColor
        cell!.layer.borderWidth = 1
        cell!.layer.cornerRadius = 16
        
        return cell!
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView {
        case teamsCollectionView:
            let detailsVC = TeamDetails(nibName: String(describing: TeamDetails.self), bundle: nil)
            
            detailsVC.selectedTeam = teams[indexPath.row]
            
            self.present(detailsVC, animated: true, completion: nil)
        default:
            collectionView.deselectItem(at: indexPath, animated: true)
        }
        
   
    }
    
    func customTeamCell(collectionView: UICollectionView, indexPath: IndexPath)-> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath as IndexPath) as! TeamsCollectionViewCell
        let team = self.teams[indexPath.row]
        cell.teamName.text = team.strTeam
        cell.teamLogu.sd_setImage(with: URL(string: team.strTeamBadge!), placeholderImage: UIImage(named: "PlaceHolder"))
        cell.teamLogu.setImageViewRounded()
        return cell as UICollectionViewCell
    }
    
    func customUpcomingEventCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcomingEventCell", for: indexPath as IndexPath) as! UpcomingEventCollectionViewCell
        let event = self.upcomingEvents[indexPath.row]
        cell.eventDateTime.text = "\(event.dateEvent!) - \(event.strTime!)"
        cell.eventPlace.text = event.strVenue!
        cell.background.sd_setImage(with: URL(string: event.strThumb!), placeholderImage: UIImage(named: "PlaceHolder"))
        cell.background.layer.borderColor = UIColor.black.cgColor
        cell.background.layer.borderWidth = 1
        cell.background.layer.cornerRadius = 16
        return cell as UICollectionViewCell
    }
    
    func customLastReaultCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latestResultCell", for: indexPath as IndexPath) as! LatestResultCollectionViewCell
        let result: LatestResult = self.latestResult[indexPath.row]
        cell.homeTeam.text = result.strHomeTeam
        cell.awayTeam.text = result.strAwayTeam
        cell.result.text = "\(result.intHomeScore ?? "3") : \(result.intAwayScore ?? "0")"
        return cell as UICollectionViewCell
    }
    
    
    
    
}

