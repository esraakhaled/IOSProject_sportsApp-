
//
//  LatestResult.swift
//  Sports
//
//  Created by yasmeen hosny on 5/5/22.
//  Copyright © 2022 iti. All rights reserved.
//

import UIKit

struct LatestResult: Codable{
    let strHomeTeam: String?
    let strAwayTeam: String?
    let intAwayScore: String?
    let intHomeScore: String?
    let dateEvent: String?
    let idHomeTeam: String?
    let idAwayTeam: String?
}

struct LatestResultResponse: Codable {
    let events: [LatestResult]?
}


