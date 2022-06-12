//
//  NetworkService.swift
//  FootballStandings
//
//  Created by BolKab on 06.06.2022.
//

import Foundation


protocol AllLeaguesNetworkProtocol {
  func getAllLeaguesModel(completion: @escaping (AllLeaguesProtocol?) -> Void)
}

protocol AllSeasonsForLeagueProtocol {
  func getAllSeasonsForLeague(id: String, completion: @escaping (SeasonsModelProtocol?) -> Void)
}

protocol FetchLeagueDetailsProtocol {
  func getLeagueDetailsForSeason(leagueId: String, seasonYear: String, completion: @escaping (LeagueDetailModelProtocol?) -> Void)
}



final class NetworkService {
  
  // MARK: Variables
  
  
}


// MARK: Get All Leagues
extension NetworkService: AllLeaguesNetworkProtocol {
  
  func getAllLeaguesModel(completion: @escaping (AllLeaguesProtocol?) -> Void) {
    
    guard let url = URL(string: LeaguesConstants.getAllLeaguesURL) else { return }
    
    var model: AllLeaguesProtocol?
    URLSession.shared.dataTask(with: url) { data, _, error in
      
      // Error
      if let error = error {
        print(error.localizedDescription)
        return
      }
      
      // Data
      guard let data = data else { return }
      do {
        model = try JSONDecoder().decode(AllLeaguesModel.self, from: data)
        completion(model)
        
      } catch let error {
        print(error.localizedDescription)
        completion(nil)
      }
      
    }.resume()
    
  }
  
  
  // Fetch Image Data
  static func fetchLogoImage(imageStr: String) -> Data? {
    
    guard let url = URL(string: imageStr) else { return nil }
    
    var data: Data?
    do {
      data = try Data(contentsOf: url)
      
    } catch let error {
      print(error.localizedDescription)
    }
    
    return data
  }
}


// MARK: Fetch Seasons
extension NetworkService: AllSeasonsForLeagueProtocol {
  
  func getAllSeasonsForLeague(id: String, completion: @escaping (SeasonsModelProtocol?) -> Void) {
    
    guard let url = URL(string: SeasonsConstants.getSeasonsUrlFirst + id + SeasonsConstants.getSeasonsUrlSecond) else {
      completion(nil)
      return
    }
    
    URLSession.shared.dataTask(with: url) { data, _, error in
      
      // Error
      if let error = error {
        print(error.localizedDescription)
        return
      }
      
      // Data
      guard let data = data else { return }
      do {
        let model = try JSONDecoder().decode(SeasonsModel.self, from: data)
        completion(model)
        
      } catch let error {
        print(error.localizedDescription)
        completion(nil)
      }
      
    }.resume()
    
  }
  
}


// MARK: Fetch League Details
extension NetworkService: FetchLeagueDetailsProtocol {
  
  func getLeagueDetailsForSeason(leagueId: String, seasonYear: String, completion: @escaping (LeagueDetailModelProtocol?) -> Void) {
    
    guard let url = URL(string: LeagueDetailConstants.urlFirst + leagueId + LeagueDetailConstants.urlSecond + seasonYear + LeagueDetailConstants.urlThird) else {
      completion(nil)
      return
    }
    
    URLSession.shared.dataTask(with: url) { data, _, error in
      
      // Error
      if let error = error {
        print(error.localizedDescription)
        return
      }
      
      // Data
      guard let data = data else { return }
      do {
        let model = try JSONDecoder().decode(LeagueDetailModel.self, from: data)
        completion(model)
        
      } catch let error {
        print(error.localizedDescription)
        completion(nil)
      }
      
    }.resume()
  }
  
}



