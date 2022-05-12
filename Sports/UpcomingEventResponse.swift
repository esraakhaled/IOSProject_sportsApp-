//
//  UpcomingEvent.swift
//  Sports
//
//  Created by yasmeen hosny on 5/5/22.
//  Copyright © 2022 iti. All rights reserved.
//

import UIKit

struct UpcomingEventResponse: Codable{
    let events: [UpcomingEvent]?
}

struct UpcomingEvent: Codable {
    let strEvent: String?
    let dateEvent: String?
    let strTime: String?
    let idHomeTeam: String?
    let idAwayTeam: String?
    let strVenue: String?
    let strThumb: String?
}

