//
//  SeasonsTableView.swift
//  FootballStandings
//
//  Created by BolKab on 08.06.2022.
//

import UIKit


protocol SeasonsTableViewProtocol: AnyObject {
  var presenter: SeasonsTablePresenterProtocol! { get set }
}


final class SeasonsTableView: UITableView, SeasonsTableViewProtocol {
  
  // MARK: Variables
  var presenter: SeasonsTablePresenterProtocol!
  
  var showLeagueDetailVC: ((String) -> Void)!
  
  
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
    self.register(SeasonsCell.self, forCellReuseIdentifier: SeasonsCell.reuseId)
  }
  
  
  convenience init(presenter: SeasonsTablePresenterProtocol, frame: CGRect, style: UITableView.Style) {
    self.init(frame: frame, style: style)
    self.presenter = presenter
  }
  
}


// MARK: Delegate & DataSourse
extension SeasonsTableView: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let presenter = self.presenter else { return 0 }
    return presenter.model.seasons.count
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: SeasonsCell.reuseId, for: indexPath) as! SeasonsCell
    
    guard let presenter = self.presenter else { return cell }
    cell.setCell(model: presenter.model.seasons[indexPath.row])
    
    return cell
  }
  
}


// MARK: Row Height
extension SeasonsTableView {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    var rowHeight = SeasonsConstants.tableCellHeight
    
    let titleWidth = ceil(self.presenter.model.seasons[indexPath.row].name.calculateWidthtBy(font: .titleFont()))
    
    if titleWidth > tableView.frame.width {
      rowHeight += 20
    }
    
    return rowHeight
  }
}


// MARK: Select
extension SeasonsTableView {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {    
    self.showLeagueDetailVC("\(self.presenter.model.seasons[indexPath.row].date)")
  }
}





