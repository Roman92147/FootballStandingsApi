//
//  LeagueDetailVC.swift
//  FootballStandings
//
//  Created by BolKab on 09.06.2022.
//

import UIKit


protocol LeagueDetailViewProtocol: AnyObject {
  func setAndShowDetails()
  func setTeamImage(index: Int)
}


final class LeagueDetailVC: UIViewController {
  
  // MARK: Interface
  private var actIndicator = UIActivityIndicatorView()
  
  private var leagueDetailTable: LeagueDetailTableView!
  
  
  // MARK: Variables
  var presenter: LeagueDetailPresenterProtocol! {
    didSet {
      guard self.leagueDetailTable != nil else { return }
      let tablePresenter = self.getLeagueDetailsTablePresenter()
      self.leagueDetailTable.presenter = tablePresenter
      self.presenter.tablePresenter = tablePresenter
      self.setAndShowDetails()
    }
  }
  
  
  // MARK: Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .white
    
    self.actIndicator.isHidden = false
    self.actIndicator.startAnimating()
    
    // Subviews
    self.addSubviews()
  }
  
  
  // Interface
  override func viewWillLayoutSubviews() {
    self.overlayInterface()
  }
  
  
  // MARK: League Details Table Presenter
  private func getLeagueDetailsTablePresenter() -> LeagueDetailTablePresenter {
    let model = self.presenter.getDetailTableModel()
    return LeagueDetailTablePresenter(leagueDetailTableView: self.leagueDetailTable, leagueDetailTableModel: model)
  }
  
}

// MARK: Show Details
extension LeagueDetailVC: LeagueDetailViewProtocol {
  func setAndShowDetails() {
    DispatchQueue.main.async {
      self.leagueDetailTable.reloadData()
      self.setTitleText()
      self.actIndicator.stopAnimating()
      self.actIndicator.isHidden = true
      UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear, animations: { [unowned self] in
        self.leagueDetailTable.alpha = 1
      }, completion: nil)
    }
  }
}


// MARK: Layout
extension LeagueDetailVC {
  
  private func addSubviews() {
    self.view.addSubview(self.actIndicator)
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Seasons", style: .plain, target: self, action: #selector(self.showSeasonsPopover(_:)))
  }
  
  
  private func overlayInterface() {
    let safeAreaInsets = self.view.safeAreaInsets
    
    // title
    self.setTitleText()
    
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
    if self.leagueDetailTable == nil {
      self.leagueDetailTable = LeagueDetailTableView(frame: tableFrame, style: .plain)
      self.view.addSubview(self.leagueDetailTable)
      self.leagueDetailTable.alpha = 0
      self.leagueDetailTable.allowsSelection = false
    } else {
      self.leagueDetailTable.frame = tableFrame
    }
  }
  
  
  // Set Imaage
  func setTeamImage(index: Int) {
    self.leagueDetailTable.setTeamImage(index: index)
  }
  
  // Set title
  private func setTitleText() {
    let selectSeasonStr = "\(self.presenter.model?.data?.season ?? 0) - \((self.presenter.model?.data?.season ?? 0) + 1)"
    self.navigationItem.title = selectSeasonStr
  }
  
}



// MARK: Show Seasons Popover
extension LeagueDetailVC {
  
  @objc private func showSeasonsPopover(_ sender: UIBarButtonItem) {
    guard let popoverModel = self.presenter.seasonsPopoverModel, popoverModel.status else { return }
    
    guard let view = sender.value(forKey: "view") as? UIView else { return }
    
    let vc = SeasonsPopoverView(sourceView: self.view, sourceRect: view.frame, sender: sender)
    vc.presenter = SeasonsPopoverPresenter(seasonsPopoverTableView:  vc,
                                           seasonsPopoverTableModel: self.presenter.seasonsPopoverModel)
    vc.changeSeasonDelegate = self
    self.present(vc, animated: true)
  }
  
}

// MARK: Change Season Delegate
extension LeagueDetailVC: ChangeSeasonDelegate {
  func changeSeason(date: Int) {
    
    UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: { [weak self] in
      self?.leagueDetailTable.alpha = 0
    }, completion: { [weak self] _ in
      self?.actIndicator.startAnimating()
    })
    
    // Fetch data
    let networkServise: FetchLeagueDetailsProtocol = NetworkService()
    networkServise.getLeagueDetailsForSeason(leagueId: self.presenter.leagueId!, seasonYear: "\(date)", completion: { [unowned self] model in
      if let modelUnw = model {
        DispatchQueue.main.async { [unowned self] in
          self.presenter.model = modelUnw
        }
      }
    })
  }
  
  
}

