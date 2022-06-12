//
//  SeasonsPresenter.swift
//  FootballStandings
//
//  Created by BolKab on 07.06.2022.
//

import Foundation


protocol SeasonsPresenterProtocol {
  var view:  SeasonsViewProtocol { get set }
  var model: SeasonsModelProtocol  { get set }
  
  var leagueId: String { get set }
  
  func getSeasonsTableModel() -> AllSeasonsDataModelProtocol
  func getSeasonsForPopover(selectSeason: String) -> SeasonsPopoverDataModelProtocol
}


final class SeasonsPresenter {
  
  // MARK: Variables
  unowned var view: SeasonsViewProtocol
  var model: SeasonsModelProtocol
  
  var leagueId: String
  
  // MARK: Methods
  required init(view: SeasonsViewProtocol, model: SeasonsModelProtocol, leagueId: String) {
    self.view = view
    self.model = model
    self.leagueId = leagueId
  }
  
}


// MARK: Get Seasons
extension SeasonsPresenter: SeasonsPresenterProtocol {
  
  func getSeasonsTableModel() -> AllSeasonsDataModelProtocol {
    guard let status = self.model.status, status else { return AllSeasonsDataModel(status: false, leagueId: "", seasons: []) }
    
    var tableModel = AllSeasonsDataModel(status:   true,
                                         leagueId: self.leagueId,
                                         seasons:  [])
    
    guard self.model.data!.seasons!.count > 0 else { return tableModel }
    for i in 0 ..< self.model.data!.seasons!.count {
      
      let seasonModel = SeasonTableModel(name:      self.model.data?.seasons?[i].displayName ?? "",
                                         abbr:      self.model.data?.seasons?[i].types?[0].abbreviation ?? "",
                                         date:      self.model.data?.seasons?[i].year ?? 0,
                                         startDate: (self.model.data?.seasons?[i].startDate ?? "").convertToViewDate(),
                                         endDate:   (self.model.data?.seasons?[i].endDate ?? "").convertToViewDate(),
                                         standings: self.model.data?.seasons?[i].types?[0].hasStandings ?? false)
      
      tableModel.seasons.append(seasonModel)
    }
    
    return tableModel
  }
  
}



// MARK: Get seasons for detail popover
extension SeasonsPresenter {
  
  func getSeasonsForPopover(selectSeason: String) -> SeasonsPopoverDataModelProtocol {
    guard let status = self.model.status, status else { return SeasonsPopoverDataModel(status: false, defSeason: "", seasons: []) }
    
    var tableModel = SeasonsPopoverDataModel(status: true, defSeason: selectSeason, seasons: [])
    
    guard self.model.data!.seasons!.count > 0 else { return tableModel }
    for i in 0 ..< self.model.data!.seasons!.count {
      
      let seasonDate = self.model.data!.seasons![i].year ?? 0
      let seasonDateStr = "\(self.model.data!.seasons![i].year ?? 0) - \((self.model.data!.seasons![i].year ?? 0) + 1)"
      tableModel.seasons.append(SeasonsPopoverModel(seasonDate: seasonDate, seasonDateStr: seasonDateStr))
    }
    
    return tableModel
  }
  
}

