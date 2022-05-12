//
//  ApiCall.swift
//  Sports
//
//  Created by Doaa Essam on 5/1/22.
//  Copyright © 2022 iti. All rights reserved.
//

import Foundation
import  Alamofire

protocol ApiProtocal {
    
    static func getAllSports( context :AnyObject,completion : @escaping (SportsJson?, Error?)->())

    static func getAllLeagues(sportName : String,sportCountry:String, completion : @escaping ([city]?, Error?)->())

    
    static func getTeamsForLeague(leagueName: String, completion : @escaping ([Team]?, Error?)->())
    static func getUpcomingEvents(leagueID: String, round: String, season: String, completion: @escaping (UpcomingEventResponse?, Error?)->())
    
    static func getLatestResults(leagueID: String, round: String, season: String, completion: @escaping (LatestResultResponse?, Error?)->())


}

class ApiCall : ApiProtocal{
    
    static func getAllLeagues(sportName: String, sportCountry: String, completion: @escaping ([city]?, Error?) -> ()) {
             let parameters: Parameters = [
                  "s": sportName,
                  "c":sportCountry
                  ]
             // AF.request(URLS.url,parameters: parameters,encoding: JSONEncoding(options: [])
              AF.request(URLS.url,method: .post,parameters: parameters,encoding: URLEncoding.queryString)
                        .validate().responseDecodable(of: apiCallData.self) { (response) in
                      switch response.result {
                      case .success( _):
                          guard let leagues = response.value?.countrys
                          else {
                              print("error")
                              return }
                        
                          completion(leagues,nil)
              
                      case .failure(let error):
                          print(error.localizedDescription)

                          completion(nil , error)
                     
                      }
                  }
          }
      
    
    
     var allLeagues = [city]()
     static func getAllSports( context :AnyObject,completion : @escaping (SportsJson?, Error?)->()) {
        
        AF.request(URLS.allSportsUrl)
                .validate()
                .responseDecodable(of: SportsJson.self) { (response) in
                    
                    switch response.result {
                    
                    case .success( _):
                        print("sucess  ya d3d3")
                        guard let AllSportsData = response.value
                        else {
                            return
                            
                        }
                        print(AllSportsData)
                        completion(AllSportsData,nil)
                        print(AllSportsData)
                        
                    case .failure(let error):
                        print("fail   ya d3d3")
                        print(error)

                        completion(nil , error)
                        
                        
                    }
                }
        
      
        
}
    
    
    
    static func getTeamsForLeague(leagueName: String,
                                  completion : @escaping ([Team]?, Error?) -> ()){
        
        let baseURL = "https://www.thesportsdb.com/api/v1/json/2"
        
        let endPoint = "/search_all_teams.php?l=\(leagueName)"
        
        let path = "\(baseURL)\(endPoint)"
        
        let url = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        
     //   let url: String = URLs.teamsByLeagueName + leagueName
        AF.request(url!, method: .get, parameters: [:], encoding: URLEncoding.queryString)
            .validate()
            .responseDecodable(of: TeamsResponse.self) { (response) in
                
                switch response.result {
                case .success( _):
                    guard let teams = response.value?.teams else {
                        print("no teams data")
                        return
                    }
                    completion(teams,nil)
                case .failure(let error):
                    print(error)
                    completion(nil , error)
                }
            }
    }
    
    static func getUpcomingEvents(leagueID: String = "4328", round: String = "38", season: String = "2021-2022", completion: @escaping (UpcomingEventResponse?, Error?) -> ()) {
        
        let parameters: Parameters = [
            "id": leagueID,
            "r": round,
            "s": season
        ]
        AF.request(URLS.upcomingEventsByIdRaoundSeason, method: .get, parameters: parameters, encoding: URLEncoding.queryString)
                  .validate().responseDecodable(of: UpcomingEventResponse.self) { (response) in
                switch response.result {
                case .success( _):
                    guard let events = response.value else {
                        print("no events data")
                        return
                    }
                    completion(events,nil)
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(nil , error)
                    }
            }
    }
    
    static func getLatestResults(leagueID: String = "4328", round: String = "35", season: String = "2021-2022", completion: @escaping (LatestResultResponse?, Error?) -> ()) {
        let parameters: Parameters = [
            "id": leagueID,
            "r": round,
            "s": season
        ]
        AF.request(URLS.upcomingEventsByIdRaoundSeason, method: .get, parameters: parameters, encoding: URLEncoding.queryString)
                  .validate().responseDecodable(of: LatestResultResponse.self) { (response) in
                switch response.result {
                case .success( _):
                    guard let events = response.value else {
                        print("no events data")
                        return
                    }
                    completion(events,nil)
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(nil , error)
                    }
            }
    }

}
