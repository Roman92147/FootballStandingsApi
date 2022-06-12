//
//  SeasonsVC.swift
//  FootballStandings
//
//  Created by BolKab on 07.06.2022.
//

import UIKit

protocol SeasonsViewProtocol: AnyObject {
  func setAndShowSeasons()
}


final class SeasonsVC: UIViewController {
  
  // MARK: Interface
  private var actIndicator = UIActivityIndicatorView()
  
  private var seasonsTable: SeasonsTableView!
  
  
  // MARK: Variables
  var presenter: SeasonsPresenterProtocol! {
    didSet {
      guard self.seasonsTable != nil else { return }
      self.seasonsTable.presenter = self.getSeasonsTablePresenter()
      self.setAndShowSeasons()
    }
  }
  
  
  
  // MARK: Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .white
    
    self.actIndicator.isHidden = false
    self.actIndicator.startAnimating()
    
    self.addSubviews()
  }
  
  
  // Interface
  override func viewDidLayoutSubviews() {
    self.overlayInterface()
  }
  
  
  // Set table closure
  private func setShowLeagueDetailsVCClosure() {
    self.seasonsTable.showLeagueDetailVC = { [unowned self] seasonYear in
      self.showLeagueDetailVC(seasonYear: seasonYear)
    }
  }
  
  
  // MARK: Leagues Table Presenter
  private func getSeasonsTablePresenter() -> SeasonsTablePresenterProtocol {
    let model = self.presenter.getSeasonsTableModel()
    return SeasonsTablePresenter(seasonsTableView: self.seasonsTable, seasonsTableModel: model)
  }
}


// MARK: Set Seasons
extension SeasonsVC: SeasonsViewProtocol {
  
  func setAndShowSeasons() {
    DispatchQueue.main.async {
      self.seasonsTable.reloadData()
      self.actIndicator.stopAnimating()
      self.actIndicator.isHidden = true
      self.seasonsTable.alpha = 0
      self.seasonsTable.isHidden = false
      UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear, animations: { [unowned self] in
        self.seasonsTable.alpha = 1
      }, completion: nil)
    }
  }
  
}


// MARK: Layout
extension SeasonsVC {
  
  private func addSubviews() {
    self.view.addSubview(self.actIndicator)
  }
  
  
  private func overlayInterface() {
    let safeAreaInsets = self.view.safeAreaInsets
    let tableInset = LeaguesConstants.leaguesTableInset
    
    // actIndicator
    let actIndicatorSize = LeaguesConstants.actIndicatorSize
    self.actIndicator.frame = CGRect(x:      (self.view.frame.width - actIndicatorSize.width) / 2,
                                     y:      (self.view.frame.height - actIndicatorSize.height) / 2,
                                     width:  actIndicatorSize.width,
                                     height: actIndicatorSize.height)
    
    
    // leaguesTable
    let tableFrame = CGRect(x:      safeAreaInsets.left + tableInset,
                            y:      safeAreaInsets.top,
                            width:  self.view.bounds.width - (safeAreaInsets.left + safeAreaInsets.right) - 2 * tableInset,
                            height: self.view.bounds.height - (safeAreaInsets.top + safeAreaInsets.bottom))
    if self.seasonsTable == nil {
      self.seasonsTable = SeasonsTableView(frame: tableFrame, style: .plain)
      self.setShowLeagueDetailsVCClosure()
      self.seasonsTable.isHidden = true
      self.view.addSubview(self.seasonsTable)
    } else {
      self.seasonsTable.frame = tableFrame
    }
  }
  
}


// MARK: Show League Details VC
extension SeasonsVC {
  
  private func showLeagueDetailVC(seasonYear: String) {
    
    // Show VC
    let vc = LeagueDetailVC()
    let presenter = LeagueDetailPresenter(view: vc, model: nil, leagueId: nil)
    vc.presenter = presenter
    
    self.navigationController?.pushViewController(vc, animated: true)
    
    
    // Fetch data
    let networkServise: FetchLeagueDetailsProtocol = NetworkService()
    networkServise.getLeagueDetailsForSeason(leagueId: self.presenter.leagueId, seasonYear: seasonYear, completion: { model in
      var presenterIn: LeagueDetailPresenterProtocol!
      if let modelUnw = model {
        presenterIn = LeagueDetailPresenter(view: vc, model: modelUnw, leagueId: self.presenter.leagueId)
        presenterIn.seasonsPopoverModel = self.presenter.getSeasonsForPopover(selectSeason: seasonYear)
      } else {
        presenterIn = LeagueDetailPresenter(view: vc, model: nil, leagueId: nil)
      }
      
      DispatchQueue.main.async {
        vc.presenter = presenterIn
      }
    })
    
  }
  
}

