//
//  SeasonsTablePresenter.swift
//  FootballStandings
//
//  Created by BolKab on 08.06.2022.
//

import Foundation


protocol SeasonsTablePresenterProtocol {
  var view:  SeasonsTableViewProtocol    { get set }
  var model: AllSeasonsDataModelProtocol { get set }
}


final class SeasonsTablePresenter: SeasonsTablePresenterProtocol {
  
  // MARK: Variables
  unowned var view: SeasonsTableViewProtocol
  var model: AllSeasonsDataModelProtocol
  
  
  // MARK: Methods
  required init(seasonsTableView: SeasonsTableViewProtocol, seasonsTableModel: AllSeasonsDataModelProtocol) {
    self.view  = seasonsTableView
    self.model = seasonsTableModel
  }
  
  
}



