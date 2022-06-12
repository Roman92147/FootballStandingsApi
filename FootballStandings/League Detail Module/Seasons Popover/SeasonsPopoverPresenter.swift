//
//  SeasonsPopoverPresenter.swift
//  FootballStandings
//
//  Created by BolKab on 11.06.2022.
//

protocol SeasonsPopoverPresenterProtocol {
  var view:  SeasonsPopoverViewProtocol      { get set }
  var model: SeasonsPopoverDataModelProtocol { get set }
}


final class SeasonsPopoverPresenter: SeasonsPopoverPresenterProtocol {
  
  // MARK: Variables
  unowned var view: SeasonsPopoverViewProtocol
  var model: SeasonsPopoverDataModelProtocol
  
  
  // MARK: Methods
  required init(seasonsPopoverTableView: SeasonsPopoverViewProtocol, seasonsPopoverTableModel: SeasonsPopoverDataModelProtocol) {
    self.view  = seasonsPopoverTableView
    self.model = seasonsPopoverTableModel
  }
  
}
