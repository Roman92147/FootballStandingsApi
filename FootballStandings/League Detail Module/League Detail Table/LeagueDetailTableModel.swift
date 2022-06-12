//
//  LeagueDetailTableModel.swift
//  FootballStandings
//
//  Created by BolKab on 09.06.2022.
//

import Foundation


// MARK: Protocols
protocol LeagueDetailTableModelProtocol {
  var status: Bool { get set }
  var data:  [LeagueDetailTableDataModelProtocol] { get set }
}

protocol LeagueDetailTableDataModelProtocol {
  var logo:   Data?  { get set }
  var name:   String { get set }
  var abbr:   String { get set }
  var league: LeagueDeatilTableModelProtocol? { get set }
  var sizes:  SizeAndInsetsModelProtocol { get set }
  
}

protocol LeagueDeatilTableModelProtocol {
  var league: String { get set }
  var rank:   Int    { get set }
}

protocol SizeAndInsetsModelProtocol {
  var height: Double { get set }
  var inset:  Double { get set }
}


// MARK: Model
struct LeagueDetailTableModel: LeagueDetailTableModelProtocol {
  var status: Bool
  var data:   [LeagueDetailTableDataModelProtocol]
}

struct LeagueDetailTableDataModel: LeagueDetailTableDataModelProtocol {
  var logo:   Data?
  var name:   String
  var abbr:   String
  var league: LeagueDeatilTableModelProtocol?
  var sizes: SizeAndInsetsModelProtocol
}

struct LeagueDeatilTableModel: LeagueDeatilTableModelProtocol {
  var league: String
  var rank:   Int
}

struct SizeAndInsetsModel: SizeAndInsetsModelProtocol {
  var height: Double
  var inset:  Double
}


