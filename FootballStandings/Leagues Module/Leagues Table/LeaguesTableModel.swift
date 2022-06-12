//
//  LeaguesTableModel.swift
//  FootballStandings
//
//  Created by BolKab on 06.06.2022.
//

import Foundation


// MARK: Protocols
protocol AllLeaguesTableModelProtocol {
  var leagues: [LeagueTableModelProtocol] { get set }
}

protocol LeagueTableModelProtocol {
  var id:    String               { get set }
  var title: String               { get set }
  var abbr:  String               { get set }
  var logos: LeagueLogosProtocol  { get set }
}


// MARK: Model
struct AllLeaguesTableModel: AllLeaguesTableModelProtocol {
  var leagues: [LeagueTableModelProtocol]
}

struct LeagueTableModel: LeagueTableModelProtocol {
  var id:    String
  var title: String
  var abbr:  String
  var logos: LeagueLogosProtocol
}


