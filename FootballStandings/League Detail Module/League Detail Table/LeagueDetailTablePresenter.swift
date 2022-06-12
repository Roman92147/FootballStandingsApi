//
//  LeagueDetailTablePresenter.swift
//  FootballStandings
//
//  Created by BolKab on 09.06.2022.
//


protocol LeagueDetailTablePresenterProtocol {
  var view:  LeagueDetailTableViewProtocol  { get set }
  var model: LeagueDetailTableModelProtocol { get set }
}


final class LeagueDetailTablePresenter: LeagueDetailTablePresenterProtocol {
  
  // MARK: Variables
  unowned var view: LeagueDetailTableViewProtocol
  var model: LeagueDetailTableModelProtocol
  
  
  // MARK: Methods
  required init(leagueDetailTableView: LeagueDetailTableViewProtocol, leagueDetailTableModel: LeagueDetailTableModelProtocol) {
    self.view  = leagueDetailTableView
    self.model = leagueDetailTableModel
  }
  
}
