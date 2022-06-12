//
//  SeasonsPopoverModel.swift
//  FootballStandings
//
//  Created by BolKab on 11.06.2022.
//


// MARK: Protocols
protocol SeasonsPopoverDataModelProtocol {
  var status:    Bool   { get set }
  var defSeason: String { get set }
  var seasons: [SeasonsPopoverModelProtocol] { get set }
}

protocol SeasonsPopoverModelProtocol {
  var seasonDate:    Int    { get set }
  var seasonDateStr: String { get set }
}



// MARK: Model
struct SeasonsPopoverDataModel: SeasonsPopoverDataModelProtocol {
  var status:    Bool
  var defSeason: String
  var seasons:   [SeasonsPopoverModelProtocol]
}

struct SeasonsPopoverModel: SeasonsPopoverModelProtocol {
  var seasonDate:    Int
  var seasonDateStr: String
}

