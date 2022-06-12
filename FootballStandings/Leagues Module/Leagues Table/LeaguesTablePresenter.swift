//
//  LeaguesTablePresenter.swift
//  FootballStandings
//
//  Created by BolKab on 06.06.2022.
//

import Foundation


protocol LeaguesTablePresenterProtocol {
  var view:  LeaguesTableViewProtocol     { get set }
  var model: AllLeaguesTableModelProtocol { get set }
}


final class LeaguesTablePresenter: LeaguesTablePresenterProtocol {
  
  // MARK: Variables
  unowned var view: LeaguesTableViewProtocol
  var model: AllLeaguesTableModelProtocol
  
  
  // MARK: Methods
  required init(leaguesTableView: LeaguesTableViewProtocol, leaguesTableModel: AllLeaguesTableModelProtocol) {
    self.view  = leaguesTableView
    self.model = leaguesTableModel
  }
  
  
}
