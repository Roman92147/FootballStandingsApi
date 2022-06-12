//
//  LeaguesVC.swift
//  FootballStandings
//
//  Created by BolKab on 06.06.2022.
//

import UIKit


protocol LeaguesViewProtocol: AnyObject {
  func setAndShowLeagues()
}



final class LeaguesVC: UIViewController {
  
  // MARK: Interface
  private var actIndicator = UIActivityIndicatorView()
  
  private var leaguesTable: LeaguesTableView!
  
  
  // MARK: Variables
  var presenter: LeaguesPresenterProtocol! {
    didSet {
      guard self.leaguesTable != nil else { return }
      self.leaguesTable.presenter = self.getLeaguesTablePresenter()
      self.setAndShowLeagues()
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
  
  
  // MARK: Leagues Table Presenter
  private func getLeaguesTablePresenter() -> LeaguesTablePresenterProtocol {
    let model = self.presenter.getLeaguesTableModel()
    return LeaguesTablePresenter(leaguesTableView:  self.leaguesTable,
                                 leaguesTableModel: model)
  }
  
  
  // Set table closure
  private func setShowSeasonsVCClosure() {
    self.leaguesTable.showSeasonsViewClosure = { [unowned self] id in
      self.showSeasonsVC(id: id)
    }
  }
  
  
  // MARK: Kill VC
  deinit {
    print("Kill Leagues VC!")
  }
  
}


// MARK: Get Leagues
extension LeaguesVC: LeaguesViewProtocol {
  
  func setAndShowLeagues() {
    DispatchQueue.main.async {
      self.leaguesTable.reloadData()
      self.actIndicator.stopAnimating()
      self.actIndicator.isHidden = true
      self.leaguesTable.alpha = 0
      self.leaguesTable.isHidden = false
      UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear, animations: { [unowned self] in
        self.leaguesTable.alpha = 1
      }, completion: nil)
    }
    
  }
  
}


// MARK: Layout
extension LeaguesVC {
  
  private func addSubviews() {
    self.view.addSubview(self.actIndicator)
  }
  
  
  private func overlayInterface() {
    let safeAreaInsets = self.view.safeAreaInsets
    
    // actIndicator
    let actIndicatorSize = LeaguesConstants.actIndicatorSize
    self.actIndicator.frame = CGRect(x:      (self.view.frame.width - actIndicatorSize.width) / 2,
                                     y:      (self.view.frame.height - actIndicatorSize.height) / 2,
                                     width:  actIndicatorSize.width,
                                     height: actIndicatorSize.height)
    
    // leaguesTable
    let tableInset = LeaguesConstants.leaguesTableInset
    let tableFrame = CGRect(x:      safeAreaInsets.left + tableInset,
                            y:      safeAreaInsets.top,
                            width:  self.view.bounds.width - (safeAreaInsets.left + safeAreaInsets.right) - 2 * tableInset,
                            height: self.view.bounds.height - (safeAreaInsets.top + safeAreaInsets.bottom))
    if self.leaguesTable == nil {
      self.leaguesTable = LeaguesTableView(frame: tableFrame, style: .plain)
      self.setShowSeasonsVCClosure()
      self.leaguesTable.isHidden = true
      self.view.addSubview(self.leaguesTable)
    } else {
      self.leaguesTable.frame = tableFrame
    }
    
  }
  
}


// MARK: Show Seasons VC
extension LeaguesVC {
  
  private func showSeasonsVC(id: String) {
    
    // Show VC
    let vc = SeasonsVC()
    let presenter = SeasonsPresenter(view: vc, model: SeasonsModel(status: false, data: SeasonsDataModel(desc: "", seasons: [])), leagueId: "")
    vc.presenter = presenter
    
    self.navigationController?.pushViewController(vc, animated: true)
    
    
    // Fetch data
    let networkServise: AllSeasonsForLeagueProtocol = NetworkService()
    networkServise.getAllSeasonsForLeague(id: id) { model in
      
      var presenterIn: SeasonsPresenterProtocol!
      if let modelUnw = model {
        presenterIn = SeasonsPresenter(view: vc, model: modelUnw, leagueId: id)
      } else {
        presenterIn = SeasonsPresenter(view: vc, model: SeasonsModel(status: false, data: SeasonsDataModel(desc: "", seasons: [])), leagueId: "")
      }
      vc.presenter = presenterIn
      
    }
    
  }
  
}

