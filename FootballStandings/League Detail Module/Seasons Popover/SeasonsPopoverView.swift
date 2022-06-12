//
//  SeasonsPopoverView.swift
//  FootballStandings
//
//  Created by BolKab on 11.06.2022.
//

import UIKit


protocol ChangeSeasonDelegate: AnyObject {
  func changeSeason(date: Int)
}


protocol SeasonsPopoverViewProtocol: AnyObject {
  var presenter: SeasonsPopoverPresenterProtocol! { get set }
}


final class SeasonsPopoverView: UIViewController, SeasonsPopoverViewProtocol {
  
  // MARK: Interface
  var seasonsTable = UITableView(frame: .zero, style: .plain)
  
  
  // MARK: Variables
  var presenter: SeasonsPopoverPresenterProtocol!
  
  weak var changeSeasonDelegate: ChangeSeasonDelegate?
  
  
  // MARK: Methods
  convenience init(sourceView: UIView, sourceRect: CGRect, sender: UIBarButtonItem) {
    self.init()
    
    self.modalPresentationStyle = .popover
    
    if let popover = self.popoverPresentationController {
      self.preferredContentSize = CGSize(width: LeagueDetailConstants.popoverRowSize.width, height: sourceView.bounds.height / 2)
      
      popover.permittedArrowDirections = .up
      popover.sourceView = sourceView
      popover.sourceRect = sourceRect
      popover.barButtonItem = sender
      popover.delegate = self
    }
    
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .red
    
    // Layout
    self.setSubviewws()
  }
  
  
  // Layout
  override func viewDidLayoutSubviews() {
    self.setSeasonsTableView()
  }
  
  
}


// MARK: Layout
extension SeasonsPopoverView {
  
  private func setSubviewws() {
    self.view.addSubview(self.seasonsTable)
    self.seasonsTable.delegate = self
    self.seasonsTable.dataSource = self
    self.seasonsTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
  }
  
  
  private func setSeasonsTableView() {
    let height = min(self.preferredContentSize.height, CGFloat(self.presenter.model.seasons.count) * LeagueDetailConstants.popoverRowSize.height)
    self.preferredContentSize = CGSize(width: LeagueDetailConstants.popoverRowSize.width, height: height)
    
    self.seasonsTable.frame = self.view.bounds
  }
  
}


// MARK: Seasons Table Delagate & DataSourse
extension SeasonsPopoverView: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    self.presenter.model.seasons.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    var content = cell.defaultContentConfiguration()
    content.text = self.presenter.model.seasons[indexPath.row].seasonDateStr
    content.textProperties.alignment = .center
    cell.contentConfiguration = content
    
    return cell
  }
  
}


// MARK: Select
extension SeasonsPopoverView {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.changeSeasonDelegate?.changeSeason(date: self.presenter.model.seasons[indexPath.row].seasonDate)
    self.dismiss(animated: true)
  }
}



// MARK: Popover
extension SeasonsPopoverView: UIPopoverPresentationControllerDelegate {
  func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
    return .none
  }
}
