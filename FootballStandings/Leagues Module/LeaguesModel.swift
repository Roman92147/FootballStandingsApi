//
//  LeaguesModel.swift
//  FootballStandings
//
//  Created by BolKab on 06.06.2022.
//

import Foundation


// MARK: Protocols
protocol AllLeaguesProtocol {
  var status: Bool                  { get set }
  var data:   [LeagueModelProtocol] { get set }
}

protocol LeagueModelProtocol {
  var id:    String?             { get set }
  var name:  String?             { get set }
  var slug:  String?             { get set }
  var abbr:  String?             { get set }
  var logos: LeagueLogosProtocol { get set }
}

protocol LeagueLogosProtocol {
  var light: Data? { get set }
  var dark:  Data? { get set }
}


// MARK: Model
struct AllLeaguesModel: AllLeaguesProtocol, Decodable {
  var status: Bool
  var data:   [LeagueModelProtocol]
  
  enum CodingKeys: String, CodingKey {
    case status, data
  }
  
  init(status: Bool, data: [LeagueModelProtocol]) {
    self.status = status
    self.data = data
  }
  
  init(from decoder: Decoder) throws {
    let vals = try decoder.container(keyedBy: CodingKeys.self)
    
    self.status = try vals.decode(Bool.self, forKey: .status)
    self.data = try vals.decode([LeagueModel].self, forKey: .data)
  }
}

struct LeagueModel: LeagueModelProtocol, Decodable {
  var id:    String?
  var name:  String?
  var slug:  String?
  var abbr:  String?
  var logos: LeagueLogosProtocol
  
  enum CodingKeys: String, CodingKey {
    case id, name, slug, abbr, logos
  }
  
//  init(id: String, name: String, slug: String, abbr: String, logos: LeagueLogosProtocol) {
//    self.id = id
//    self.name = name
//    self.slug = slug
//    self.abbr = abbr
//    self.logos = logos
//  }
  
  init(from decoder: Decoder) throws {
    let vals = try decoder.container(keyedBy: CodingKeys.self)
    
    self.id = try vals.decode(String.self, forKey: .id)
    self.name = try vals.decode(String.self, forKey: .name)
    self.slug = try vals.decode(String.self, forKey: .slug)
    self.abbr = try vals.decode(String.self, forKey: .abbr)
    self.logos = try vals.decode(LeagueLogosModel.self, forKey: .logos)
  }
}

struct LeagueLogosModel: LeagueLogosProtocol, Decodable {
  var light: Data?
  var dark:  Data?
  
  enum CodingKeys: String, CodingKey {
    case light, dark
  }
  
//  init(light: String, dark: String) {
//    self.light = light
//    self.dark = dark
//  }
  
  init(from decoder: Decoder) throws {
    let vals = try decoder.container(keyedBy: CodingKeys.self)
    
    let lightStr = try vals.decode(String.self, forKey: .light)
    let darkStr = try vals.decode(String.self, forKey: .dark)
    
    self.light = NetworkService.fetchLogoImage(imageStr: lightStr)
    self.dark = NetworkService.fetchLogoImage(imageStr: darkStr)
  }
}




