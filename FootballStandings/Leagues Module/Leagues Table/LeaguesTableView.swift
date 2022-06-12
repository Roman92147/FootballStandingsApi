//
//  LeaguesTableView.swift
//  FootballStandings
//
//  Created by BolKab on 06.06.2022.
//

import UIKit


protocol LeaguesTableViewProtocol: AnyObject {
  var presenter: LeaguesTablePresenterProtocol! { get set }
}


final class LeaguesTableView: UITableView, LeaguesTableViewProtocol {
  
  // MARK: Variables
  var presenter: LeaguesTablePresenterProtocol!
  
  var showSeasonsViewClosure: ((String) -> Void)!
  
  
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
    self.register(LeaguesCell.self, forCellReuseIdentifier: LeaguesCell.reuseId)
  }
  
  
  convenience init(presenter: LeaguesTablePresenterProtocol, frame: CGRect, style: UITableView.Style) {
    self.init(frame: frame, style: style)
    self.presenter = presenter
  }
  
}


// MARK: Delegate & DataSourse
extension LeaguesTableView: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let presenter = self.presenter else { return 0 }
    return presenter.model.leagues.count
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: LeaguesCell.reuseId, for: indexPath) as! LeaguesCell
    
    guard let presenter = self.presenter else { return cell }
    cell.setCell(model: presenter.model.leagues[indexPath.row])
    
    return cell
  }
  
}


// MARK: Row Height
extension LeaguesTableView {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    let labelWidth = tableView.frame.width - LeaguesConstants.leaguesTableLabelsInset - LeaguesConstants.leaguesLogoSize
    var rowHeight = LeaguesConstants.leaguesLogoSize + 2 * LeaguesConstants.leaguesTableLabelsInset
    
    let titleWidth = ceil(self.presenter.model.leagues[indexPath.row].title.calculateWidthtBy(font: .titleFont()))
    
    if titleWidth > labelWidth {
      rowHeight += 20
    }
    
    return rowHeight
  }
}


// MARK: Select
extension LeaguesTableView {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.showSeasonsViewClosure(self.presenter.model.leagues[indexPath.row].id)
  }
}

