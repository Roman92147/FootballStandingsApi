//
//  LeaguesPresenter.swift
//  FootballStandings
//
//  Created by BolKab on 06.06.2022.
//

import Foundation

protocol LeaguesPresenterProtocol {
  var view:  LeaguesViewProtocol { get set }
  var model: AllLeaguesProtocol  { get set }
  
  func getLeaguesTableModel() -> AllLeaguesTableModelProtocol
}


final class LeaguesPresenter: LeaguesPresenterProtocol {
  
  
  
  // MARK: Variables
  unowned var view: LeaguesViewProtocol
  var model: AllLeaguesProtocol
  
  
  // MARK: Methods
  required init(leaguesView: LeaguesViewProtocol, leaguesModel: AllLeaguesProtocol) {
    self.view  = leaguesView
    self.model = leaguesModel
  }
  
  
  
}


// MARK: Get Leagues Table Presenter
extension LeaguesPresenter {
  
  func getLeaguesTableModel() -> AllLeaguesTableModelProtocol {
    var tableModel = AllLeaguesTableModel(leagues: [])
    
    if self.model.status {
      for i in 0 ..< self.model.data.count {
        
        let leagueModel = LeagueTableModel(id:    self.model.data[i].id ?? "",
                                           title: self.model.data[i].name ?? "",
                                           abbr:  self.model.data[i].abbr ?? "",
                                           logos: self.model.data[i].logos)
        
        tableModel.leagues.append(leagueModel)
      }
    }
    
    
    return tableModel
  }
}
