//
//  SeasonsModel.swift
//  FootballStandings
//
//  Created by BolKab on 07.06.2022.
//

import Foundation


// MARK: Protocols
protocol SeasonsModelProtocol {
  var status: Bool? { get set }
  var data:   SeasonsDataModelProtocol? { get set }
}

protocol SeasonsDataModelProtocol {
  var desc:    String? { get set }
  var seasons: [SeasonModelProtocol]? { get set }
}

protocol SeasonModelProtocol {
  var year:        Int?    { get set }
  var startDate:   String? { get set }
  var endDate:     String? { get set }
  var displayName: String? { get set }
  var types:       [SeasonTypeModelProtocol]? { get set }
}

protocol SeasonTypeModelProtocol {
  var id:           String? { get set }
  var name:         String? { get set }
  var abbreviation: String? { get set }
  var startDate:    String? { get set }
  var endDate:      String? { get set }
  var hasStandings: Bool?   { get set }
}




// MARK: Model
struct SeasonsModel: SeasonsModelProtocol, Decodable {
  var status: Bool?
  var data:   SeasonsDataModelProtocol?
  
  
  enum CodingKeys: String, CodingKey {
    case status, data
  }
  
  init(status: Bool, data: SeasonsDataModelProtocol) {
    self.status = status
    self.data = data
  }
  
  init(from decoder: Decoder) throws {
    let vals = try decoder.container(keyedBy: CodingKeys.self)
    
    self.status = try vals.decode(Bool.self, forKey: .status)
    self.data = try vals.decode(SeasonsDataModel.self, forKey: .data)
  }
}


struct SeasonsDataModel: SeasonsDataModelProtocol, Decodable {
  var desc:    String?
  var seasons: [SeasonModelProtocol]?
  
  init(desc: String, seasons: [SeasonModelProtocol]) {
    self.desc = desc
    self.seasons = seasons
  }
  
  enum CodingKeys: String, CodingKey {
    case desc, seasons
  }
  
  init(from decoder: Decoder) throws {
    let vals = try decoder.container(keyedBy: CodingKeys.self)
    
    self.desc = try vals.decode(String.self, forKey: .desc)
    self.seasons = try vals.decode([SeasonModel].self, forKey: .seasons)
  }
}


struct SeasonModel: SeasonModelProtocol, Decodable {
  var year:        Int?
  var startDate:   String?
  var endDate:     String?
  var displayName: String?
  var types:       [SeasonTypeModelProtocol]?
  
  enum CodingKeys: String, CodingKey {
    case year, startDate, endDate, displayName, types
  }
  
  
  init(from decoder: Decoder) throws {
    let vals = try decoder.container(keyedBy: CodingKeys.self)
    
    self.year = try vals.decode(Int.self, forKey: .year)
    self.startDate = try vals.decode(String.self, forKey: .startDate)
    self.endDate = try vals.decode(String.self, forKey: .endDate)
    self.displayName = try vals.decode(String.self, forKey: .displayName)
    self.types = try vals.decode([SeasonTypesModel].self, forKey: .types)
  }
}


struct SeasonTypesModel: SeasonTypeModelProtocol, Decodable {
  var id:           String?
  var name:         String?
  var abbreviation: String?
  var startDate:    String?
  var endDate:      String?
  var hasStandings: Bool?
  
  enum CodingKeys: String, CodingKey {
    case id, name, abbreviation, startDate, endDate, hasStandings
  }
  
  
  init(from decoder: Decoder) throws {
    let vals = try decoder.container(keyedBy: CodingKeys.self)
    
    self.id = try vals.decode(String.self, forKey: .id)
    self.name = try vals.decode(String.self, forKey: .name)
    self.abbreviation = try vals.decode(String.self, forKey: .abbreviation)
    self.startDate = try vals.decode(String.self, forKey: .startDate)
    self.endDate = try vals.decode(String.self, forKey: .endDate)
    self.hasStandings = try vals.decode(Bool.self, forKey: .hasStandings)
  }
}

