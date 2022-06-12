//
//  SeasonsTableModel.swift
//  FootballStandings
//
//  Created by BolKab on 08.06.2022.
//


// MARK: Protocols
protocol AllSeasonsDataModelProtocol {
  var status:   Bool   { get set }
  var leagueId: String { get set }
  var seasons:  [SeasonTableModelProtocol] { get set }
}


protocol SeasonTableModelProtocol {
  var name:      String { get set }
  var abbr:      String { get set }
  var date:      Int    { get set }
  var startDate: String { get set }
  var endDate:   String { get set }
  var standings: Bool   { get set }
}


// MARK: Model
struct AllSeasonsDataModel: AllSeasonsDataModelProtocol {
  var status:   Bool
  var leagueId: String
  var seasons:  [SeasonTableModelProtocol]
}


struct SeasonTableModel: SeasonTableModelProtocol {
  var name:      String
  var abbr:      String
  var date:      Int
  var startDate: String
  var endDate:   String
  var standings: Bool
}


