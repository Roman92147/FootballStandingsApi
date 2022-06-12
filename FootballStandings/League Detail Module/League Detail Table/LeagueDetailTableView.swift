//
//  LeagueDetailTableView.swift
//  FootballStandings
//
//  Created by BolKab on 09.06.2022.
//

import UIKit


protocol LeagueDetailTableViewProtocol: AnyObject {
  var presenter: LeagueDetailTablePresenterProtocol! { get set }
  
  func setTeamImage(index: Int)
}


final class LeagueDetailTableView: UITableView, LeagueDetailTableViewProtocol {
  
  // MARK: Variables
  var presenter: LeagueDetailTablePresenterProtocol!
  
  
  // MARK: Methods
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)
    
    self.backgroundColor = .clear
    
    self.allowsMultipleSelection = false
    
    self.delegate = self
    self.dataSource = self
    
    // Cell Register
    self.register(LeagueDetailCell.self, forCellReuseIdentifier: LeagueDetailCell.reuseId)
  }
  
  
  convenience init(presenter: LeagueDetailTablePresenterProtocol, frame: CGRect, style: UITableView.Style) {
    self.init(frame: frame, style: style)
    self.presenter = presenter
  }
  
}


// MARK: Delegate & DataSourse
extension LeagueDetailTableView: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let presenter = self.presenter else { return 0 }
    return presenter.model.data.count
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: LeagueDetailCell.reuseId, for: indexPath) as! LeagueDetailCell
    
    guard let presenter = self.presenter else { return cell }
    cell.setCell(model: presenter.model.data[indexPath.row])
    
    return cell
  }
  
}


// MARK: Row Height
extension LeagueDetailTableView {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    let labelsWidth = tableView.frame.width - (LeagueDetailConstants.logoSize + LeagueDetailConstants.cellcontentInset)
    
    let sizes = self.getCellHeightAndInset(index: indexPath.row, labelsWidth: labelsWidth)
    if self.presenter.model.status {
      self.presenter.model.data[indexPath.row].sizes = sizes
    }
    
    return sizes.height
  }
  
  
  // Row Height
  private func getCellHeightAndInset(index: Int, labelsWidth: CGFloat) -> SizeAndInsetsModelProtocol {
    var cellHeight = LeagueDetailConstants.tableCellHeight
    
    guard self.presenter.model.status else { return SizeAndInsetsModel(height: 0, inset: 0) }
    
    var inset = LeagueDetailConstants.cellcontentInset
    var labelsCount: CGFloat = 3
    
    // title
    let titleHeight = ceil(self.presenter.model.data[index].name.calculateHeightBy(width: labelsWidth, font: .titleFont()))
    
    // abbr
    let abbrHeight = ceil(self.presenter.model.data[index].abbr.calculateHeightBy(width: labelsWidth, font: .subTitleFont()))
    
    // league
    var leagueHeight: CGFloat = 0
    if let league = self.presenter.model.data[index].league {
      let totalStr = "\(league.league) No. \(league.rank)"
      leagueHeight = totalStr.calculateHeightBy(width: labelsWidth, font: .subTitleFont())
      labelsCount -= 1
    }
    
    let totalHeight = titleHeight + abbrHeight + leagueHeight + inset * (labelsCount + 1)
    
    if cellHeight < totalHeight {
      cellHeight = totalHeight
      inset = totalHeight / (labelsCount + 1)
    }
    
    return SizeAndInsetsModel(height: cellHeight, inset: inset)
  }
}


// MARK: Set Team Image
extension LeagueDetailTableView {
  func setTeamImage(index: Int) {
    self.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
  }
}
