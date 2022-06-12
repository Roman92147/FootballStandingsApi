//
//  LeagueDetailModel.swift
//  FootballStandings
//
//  Created by BolKab on 09.06.2022.
//

import Foundation


// MARK: Protocols
protocol LeagueDetailModelProtocol {
  var status: Bool? { get set }
  var data:   LeagueDetailDataModelProtocol? { get set }
}


protocol LeagueDetailDataModelProtocol {
  var name:          String? { get set }
  var abbreviation:  String? { get set }
  var seasonDisplay: String? { get set }
  var season:        Int?    { get set }
  var standings: [LeagueDetailStandingModelProtocol]? { get set }
}


protocol LeagueDetailStandingModelProtocol {
  var team:  LeagueDetailTeamModelProtocol? { get set }
  var note:  LeagueDetailNoteModelProtocol? { get set }
  var stats: [LeagueDetailStatsModelProtocol]? { get set }
}


protocol LeagueDetailTeamModelProtocol {
  var id:               String? { get set }
  var uid:              String? { get set }
  var location:         String? { get set }
  var name:             String? { get set }
  var abbreviation:     String? { get set }
  var displayName:      String? { get set }
  var shortDisplayName: String? { get set }
  var isActive:         Bool?   { get set }
  var logos: [LeagueDetailLogosModelProtocol]? { get set }
}

protocol LeagueDetailLogosModelProtocol {
  var href:        String?   { get set }
  var width:       Int?      { get set }
  var height:      Int?      { get set }
  var alt:         String?   { get set }
  var rel:         [String]? { get set }
  var lastUpdated: String?   { get set }
}

protocol LeagueDetailNoteModelProtocol {
  var color:       String? { get set }
  var description: String? { get set }
  var rank:        Int?    { get set }
}


protocol LeagueDetailStatsModelProtocol {
  var name:             String? { get set }
  var displayName:      String? { get set }
  var shortDisplayName: String? { get set }
  var description:      String? { get set }
  var abbreviation:     String? { get set }
  var type:             String? { get set }
  var summary:          String? { get set }
  var value:            Int?    { get set }
  var displayValue:     String? { get set }
}


// MARK: Model
struct LeagueDetailModel: LeagueDetailModelProtocol, Decodable {
  var status: Bool?
  var data:   LeagueDetailDataModelProtocol?
  
  init(status: Bool, data: LeagueDetailDataModelProtocol) {
    self.status = status
    self.data   = data
  }
  
  enum CodingKeys: String, CodingKey {
    case status, data
  }
  
  init(from decoder: Decoder) throws {
    let vals = try decoder.container(keyedBy: CodingKeys.self)
    
    do {
      self.status = try vals.decode(Bool.self, forKey: .status)
    } catch {
//      print("status fail")
    }

    do {
      self.data = try vals.decode(LeagueDetailDataModel.self, forKey: .data)
    } catch {
//      print("data fail")
    }
  }
  
}


struct LeagueDetailDataModel: LeagueDetailDataModelProtocol, Decodable {
  var name:          String?
  var abbreviation:  String?
  var seasonDisplay: String?
  var season:        Int?
  var standings:     [LeagueDetailStandingModelProtocol]?
  
  enum CodingKeys: String, CodingKey {
    case name, abbreviation, seasonDisplay, season, standings
  }
  
  init(from decoder: Decoder) throws {
    let vals = try decoder.container(keyedBy: CodingKeys.self)
    
    do {
      self.name = try vals.decode(String.self, forKey: .name)
    } catch {
//      print("name fail")
    }
    
    do {
      self.abbreviation = try vals.decode(String.self, forKey: .abbreviation)
    } catch {
//      print("abbreviation fail")
    }
    
    do {
      self.seasonDisplay = try vals.decode(String.self, forKey: .seasonDisplay)
    } catch {
//      print("seasonDisplay fail")
    }
    
    do {
      self.season = try vals.decode(Int.self, forKey: .season)
    } catch {
//      print("season fail")
    }
    
    do {
      self.standings = try vals.decode([LeagueDetailStandingModel].self, forKey: .standings)
    } catch {
//      print("standings fail")
    }
  }
}


struct LeagueDetailStandingModel: LeagueDetailStandingModelProtocol, Decodable {
  var team:  LeagueDetailTeamModelProtocol?
  var note:  LeagueDetailNoteModelProtocol?
  var stats: [LeagueDetailStatsModelProtocol]?
  
  enum CodingKeys: String, CodingKey {
    case team, note, stats
  }
  
  init(from decoder: Decoder) throws {
    let vals = try decoder.container(keyedBy: CodingKeys.self)
    
    do {
      self.team = try vals.decode(LeagueDetailTeamModel.self, forKey: .team)
    } catch {
//      print("team fail")
    }
    
    do {
      self.note = try vals.decode(LeagueDetailNoteModel.self, forKey: .note)
    } catch {
//      print("note fail")
    }
    
    
    do {
      self.stats = try vals.decode([LeagueDetailStatsModel].self, forKey: .stats)
    } catch {
//      print("stats fail")
    }
  }
  
}


struct LeagueDetailTeamModel: LeagueDetailTeamModelProtocol, Decodable {
  var id:               String?
  var uid:              String?
  var location:         String?
  var name:             String?
  var abbreviation:     String?
  var displayName:      String?
  var shortDisplayName: String?
  var isActive:         Bool?
  var logos:            [LeagueDetailLogosModelProtocol]?
  
  enum CodingKeys: String, CodingKey {
    case id, uid, location, name, abbreviation, displayName, shortDisplayName, isActive, logos
  }
  
  
  init(from decoder: Decoder) throws {
    let vals = try decoder.container(keyedBy: CodingKeys.self)
    
    do {
      self.id = try vals.decode(String.self, forKey: .id)
    } catch {
//      print("id fail")
    }
    
    do {
      self.uid = try vals.decode(String.self, forKey: .uid)
    } catch {
//      print("uid fail")
    }
    
    do {
      self.location = try vals.decode(String.self, forKey: .location)
    } catch {
//      print("location fail")
    }
    
    do {
      self.name = try vals.decode(String.self, forKey: .name)
    } catch {
//      print("name fail")
    }
    
    do {
      self.abbreviation = try vals.decode(String.self, forKey: .abbreviation)
    } catch {
//      print("abbreviation fail")
    }
    
    do {
      self.displayName = try vals.decode(String.self, forKey: .displayName)
    } catch {
//      print("displayName fail")
    }
    
    do {
      self.shortDisplayName = try vals.decode(String.self, forKey: .shortDisplayName)
    } catch {
//      print("shortDisplayName fail")
    }
    
    do {
      self.isActive = try vals.decode(Bool.self, forKey: .isActive)
    } catch {
//      print("isActive fail")
    }
    
    do {
      self.logos = try vals.decode([LeagueDetailLogosModel].self, forKey: .logos)
    } catch {
//      print("logos fail")
    }
  }
  
}


struct LeagueDetailLogosModel: LeagueDetailLogosModelProtocol, Decodable {
  var href:        String?
  var width:       Int?
  var height:      Int?
  var alt:         String?
  var rel:         [String]?
  var lastUpdated: String?
  
  enum CodingKeys: String, CodingKey {
    case href, width, height, alt, rel, lastUpdated
  }
  
  init(from decoder: Decoder) throws {
    let vals = try decoder.container(keyedBy: CodingKeys.self)
    
    do {
      self.href = try vals.decode(String.self, forKey: .href)
    } catch {
//      print("href fail")
    }
    
    do {
      self.width = try vals.decode(Int.self, forKey: .width)
    } catch {
//      print("width fail")
    }
    
    do {
      self.height = try vals.decode(Int.self, forKey: .height)
    } catch {
//      print("height fail")
    }
    
    do {
      self.alt = try vals.decode(String.self, forKey: .alt)
    } catch {
//      print("alt fail")
    }
    
    do {
      self.rel = try vals.decode([String].self, forKey: .rel)
    } catch {
//      print("rel fail")
    }
    
    do {
      self.lastUpdated = try vals.decode(String.self, forKey: .lastUpdated)
    } catch {
//      print("lastUpdated fail")
    }
  }
  
}


struct LeagueDetailNoteModel: LeagueDetailNoteModelProtocol, Decodable {
  var color:       String?
  var description: String?
  var rank:        Int?
  
  enum CodingKeys: String, CodingKey {
    case color, description, rank
  }
  
  init(from decoder: Decoder) throws {
    let vals = try decoder.container(keyedBy: CodingKeys.self)
    
    do {
      self.color = try vals.decode(String.self, forKey: .color)
    } catch {
//      print("color fail")
    }
    
    do {
      self.description = try vals.decode(String.self, forKey: .description)
    } catch {
//      print("description fail")
    }
    
    do {
      self.rank = try vals.decode(Int.self, forKey: .rank)
    } catch {
//      print("rank fail")
    }
  }
  
}


struct LeagueDetailStatsModel: LeagueDetailStatsModelProtocol, Decodable {
  var name:             String?
  var displayName:      String?
  var shortDisplayName: String?
  var description:      String?
  var abbreviation:     String?
  var type:             String?
  var summary:          String?
  var value:            Int?
  var displayValue:     String?
  
  enum CodingKeys: String, CodingKey {
    case name, displayName, shortDisplayName, description, abbreviation, type, summary, value, displayValue
  }
  
  init(from decoder: Decoder) throws {
    let vals  = try decoder.container(keyedBy: CodingKeys.self)
    
    do {
      self.name = try vals.decode(String.self, forKey: .name)
    } catch {
//      print("name fail")
    }
    
    do {
      self.displayName = try vals.decode(String.self, forKey: .displayName)
    } catch {
//      print("displayName fail")
    }
    
    do {
      self.shortDisplayName = try vals.decode(String.self, forKey: .shortDisplayName)
    } catch {
//      print("shortDisplayName fail")
    }
    
    do {
      self.description = try vals.decode(String.self, forKey: .description)
    } catch {
//      print("description fail")
    }
    
    do {
      self.abbreviation = try vals.decode(String.self, forKey: .abbreviation)
    } catch {
//      print("abbreviation fail")
    }
    
    do {
      self.type = try vals.decode(String.self, forKey: .type)
    } catch {
//      print("type fail")
    }
    
    do {
      self.summary = try vals.decode(String.self, forKey: .summary)
    } catch {
//      print("summary fail")
    }
    
    do {
      self.value = try vals.decode(Int.self, forKey: .value)
    } catch {
//      print("value fail")
    }
    
    do {
      self.displayValue = try vals.decode(String.self, forKey: .displayValue)
    } catch {
//      print("displayValue fail")
    }
  }
}




