//
//  LeagueDetailPresenter.swift
//  FootballStandings
//
//  Created by BolKab on 09.06.2022.
//

import Foundation


protocol LeagueDetailPresenterProtocol {
  var view:  LeagueDetailViewProtocol   { get set }
  var model: LeagueDetailModelProtocol? { get set }
  
  var leagueId: String? { get set }
  
  var tablePresenter: LeagueDetailTablePresenterProtocol! { get set }
  var seasonsPopoverModel: SeasonsPopoverDataModelProtocol! { get set }
  
  func getDetailTableModel() -> LeagueDetailTableModelProtocol
}


final class LeagueDetailPresenter {
  
  // MARK: Variables
  unowned var view: LeagueDetailViewProtocol
  var model: LeagueDetailModelProtocol?
  
  var tablePresenter: LeagueDetailTablePresenterProtocol!
  var seasonsPopoverModel: SeasonsPopoverDataModelProtocol!
  
  var leagueId: String?
  
  
  // MARK: Methods
  required init(view: LeagueDetailViewProtocol, model: LeagueDetailModelProtocol?, leagueId: String?) {
    self.view = view
    self.model = model
    self.leagueId = leagueId
  }
  
}


// MARK: Get Details Data
extension LeagueDetailPresenter: LeagueDetailPresenterProtocol {
  func getDetailTableModel() -> LeagueDetailTableModelProtocol {
    guard let model = self.model, let status = model.status, status else { return LeagueDetailTableModel(status: false, data: []) }
    
    var tableModel = LeagueDetailTableModel(status: true,
                                            data: [])
    
    guard model.data!.standings!.count > 0 else { return tableModel }
    for i in 0 ..< model.data!.standings!.count {
      
      var logo: Data?
      DispatchQueue.global().async(qos: .userInteractive) { [weak self] in
        guard let url = URL(string: model.data?.standings?[i].team?.logos?[0].href ?? ""), let imageData = try? Data(contentsOf: url) else {
          logo = nil
          return
        }
        DispatchQueue.main.async { [weak self] in
          let index = i
          guard let selfUnw = self else { return }
          selfUnw.tablePresenter.model.data[i].logo = imageData
          selfUnw.view.setTeamImage(index: index)
        }
      }
      
      
//      if let url = URL(string: model.data?.standings?[i].team?.logos?[0].href ?? ""), let imageData = try? Data(contentsOf: url) {
//        logo = imageData
//      }
      
      
      var league: LeagueDeatilTableModelProtocol?
      if let note = model.data?.standings?[i].note {
        league = LeagueDeatilTableModel(league: note.description ?? "", rank: note.rank ?? 0)
      }
      
      let detailModel = LeagueDetailTableDataModel(logo:   logo,
                                                   name:   model.data?.standings?[i].team?.name ?? "",
                                                   abbr:   model.data?.standings?[i].team?.abbreviation ?? "",
                                                   league: league,
                                                   sizes:  SizeAndInsetsModel(height: 0, inset: 0))
      
      tableModel.data.append(detailModel)
    }
    
    
    return tableModel
  }
  
}
 



