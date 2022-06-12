//
//  LeagueDetailCell.swift
//  FootballStandings
//
//  Created by BolKab on 09.06.2022.
//


import UIKit


final class LeagueDetailCell: UITableViewCell {
  
  // MARK: Interface
  private let logo: UIImageView = {
    let view = UIImageView()
    view.backgroundColor = .clear
    
    return view
  }()
  
  private let title: UILabel = {
    let label = UILabel()
    label.font = .titleFont()
    label.textColor = .black
    label.numberOfLines = 0
    label.backgroundColor = .clear
    
    return label
  }()
  
  private let abbreviation: UILabel = {
    let label = UILabel()
    label.font = .subTitleFont()
    label.textColor = .gray
    label.numberOfLines = 0
    label.backgroundColor = .clear
    
    return label
  }()
  
  private let league: UILabel = {
    let label = UILabel()
    label.font = .subTitleFont()
    label.textColor = .black
    label.numberOfLines = 0
    label.backgroundColor = .clear
    
    return label
  }()
  
  
  // MARK: Variables
  static let reuseId = "LeagueDetailCell"
  
  private var model: LeagueDetailTableDataModelProtocol!
  
  
  // MARK: Methods
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.backgroundColor = .clear
  }
  
  
  override func prepareForReuse() {
    super.prepareForReuse()
    self.logo.image = nil
    self.title.text = ""
    self.league.text = ""
    self.abbreviation.text = ""
  }
}

// MARK: Set Cell
extension LeagueDetailCell: CellProtocol {
  
  func setCell(model: LeagueDetailTableDataModelProtocol) {
    
    // Model
    self.model = model
    
    // Subviews
    self.addSubviews()
    
    // Interface
    self.overlayInterface()
  }
  
  // Set Image
  func setImage() {
    guard let logoData = self.model.logo, let image = UIImage(data: logoData) else { return }
    self.logo.image = image
  }
  
}


// MARK: Layout
extension LeagueDetailCell {
  
  private func addSubviews() {
    self.addSubview(self.logo)
    self.addSubview(self.title)
    self.addSubview(self.abbreviation)
    if self.model.league != nil {
      self.addSubview(self.league)
    }
  }
  
  
  private func overlayInterface() {
    
    let logoInsetSize = LeagueDetailConstants.logoSize + LeagueDetailConstants.cellcontentInset
    let labelsWidth = self.frame.width - (LeagueDetailConstants.logoSize + LeagueDetailConstants.cellcontentInset)
    
    // logo
    let logoSize = LeagueDetailConstants.logoSize
    self.logo.frame = CGRect(x:      0,
                             y:      (self.model.sizes.height - logoSize) / 2,
                             width:  logoSize,
                             height: logoSize)
    self.setImage()
    
    // title
    let titleHeight = ceil(self.model.name.calculateHeightBy(width: labelsWidth, font: self.title.font))
    self.title.frame = CGRect(x:      logoInsetSize,
                              y:      self.model.sizes.inset,
                              width:  labelsWidth,
                              height: titleHeight)
    self.title.text = self.model.name

    // abbr
    let abbrHeight = ceil(self.model.abbr.calculateHeightBy(width: labelsWidth, font: self.abbreviation.font))
    self.abbreviation.frame = CGRect(x:      logoInsetSize,
                                     y:      self.title.frame.maxY + self.model.sizes.inset,
                                     width:  labelsWidth,
                                     height: abbrHeight)
    self.abbreviation.text = self.model.abbr
    
    // league
    guard let leagueData = self.model.league else { return }
    let leagueText = "\(leagueData.league) No. \(leagueData.rank)"
    let leagueHeight = ceil(leagueText.calculateHeightBy(width: labelsWidth, font: self.league.font))
    self.league.frame = CGRect(x:      logoInsetSize,
                               y:      self.abbreviation.frame.maxY + self.model.sizes.inset,
                               width:  labelsWidth,
                               height: leagueHeight)
    self.league.text = leagueText
  }
  
  
}
