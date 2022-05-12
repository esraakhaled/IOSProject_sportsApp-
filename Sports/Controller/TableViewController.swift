//
//  TableViewController.swift
//  SportsFavorite
//
//  Created by Mina   on 5/4/22.
//  Copyright © 2022 Mina  . All rights reserved.
//

import UIKit
import CoreData
import Reachability

class TableViewController: UITableViewController {
    
    var appdelegate:AppDelegate?
    var managedContext:NSManagedObjectContext?
    var entity:NSEntityDescription?
    
    var leagueArray:[NSManagedObject] = []
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
         
        
        
        appdelegate=UIApplication.shared.delegate as! AppDelegate
        managedContext=appdelegate?.persistentContainer.viewContext
        entity=NSEntityDescription.entity(forEntityName: "FavoriteLeage", in: managedContext!)
   
    let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "FavoriteLeage")
        do{
            leagueArray = try! managedContext?.fetch(fetchReq) as! [NSManagedObject]
            
            
        }catch let error as Error{
            print(error.localizedDescription)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leagueArray.count
    }
    
    func showAlert() {
        var alert = UIAlertController(title: "No Internet", message: "Check your Internet connection", preferredStyle: UIAlertController.Style.alert)
        
        var action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(action)
                
        self.present(alert, animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if checkNetwork(){
        let teamViewController = storyboard?.instantiateViewController(identifier: "LeagueDetailsViewController") as! LeagueDetailsViewController
        var data=leagueArray[indexPath.row]

     teamViewController.leagueName =  data.value(forKey: "league") as! String
     teamViewController.leagueID =  data.value(forKey: "id") as! String
            teamViewController.comeFrom = "fav"
        
            self.navigationController?.pushViewController(teamViewController, animated: true)}
        else{
            showAlert()
        }
     }
    
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoCell", for: indexPath) as! LeagueCustomCell
        
        var data=leagueArray[indexPath.row]
//        data.value(forKey: "id") as! String
      //  data.value(forKey: "badge") as! String
        data.value(forKey: "youtube") as! String
        data.value(forKey: "league") as! String
       var image=data.value(forKey: "image") as! Data
       cell.leagueImage.image=UIImage.init(data: image)
        cell.leaugeName.text = data.value(forKey: "league") as! String
           // data.value(forKey: "id") as! String
        return cell
    }
    
    
    
    func checkNetwork()->Bool{
        var state : Bool?
        do{
        let reach = try Reachability()
            if reach.isReachable{
                state=true}
            else{
                state=false}
        }catch{}
        return state!
    }

    
    
    override func tableView(_ tableView: UITableView, commit editingStyle:
    UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    managedContext?.delete(leagueArray[indexPath.row])
    leagueArray.remove(at: indexPath.row)
    tableView.deleteRows(at: [indexPath] , with: .automatic)
    tableView.reloadData()
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

