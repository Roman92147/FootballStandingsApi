//
//  LeaguesCell.swift
//  FootballStandings
//
//  Created by BolKab on 06.06.2022.
//

import UIKit


protocol CellProtocol {
  associatedtype T
  
  func setCell(model: T)
}


final class LeaguesCell: UITableViewCell {
  
  // MARK: Interface
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
  
  private let logo: UIImageView = {
    let view = UIImageView()
    view.backgroundColor = .clear
    
    return view
  }()
  
  
  // MARK: Variables
  static let reuseId = "LeaguesCell"
  
  private var cellModel: LeagueTableModelProtocol!
  
  
  // MARK: Methods
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.backgroundColor = .clear
    
    self.addSubviews()
  }
  
  
}

// MARK: Set Cell
extension LeaguesCell: CellProtocol {
  
  func setCell(model: LeagueTableModelProtocol) {
    
    self.cellModel = model
    
    // Interface
    self.overlayInterface()
  }
}


// MARK: Layout
extension LeaguesCell {
  
  private func addSubviews() {
    self.addSubview(self.logo)
    self.addSubview(self.title)
    self.addSubview(self.abbreviation)
  }
  
  
  private func overlayInterface() {
    
    let inset = LeaguesConstants.leaguesTeableCellInsets
    
    // logo
    self.logo.frame = CGRect(x:      0,
                             y:      (self.frame.height - LeaguesConstants.leaguesLogoSize) / 2,
                             width:  LeaguesConstants.leaguesLogoSize,
                             height: LeaguesConstants.leaguesLogoSize)
    if let imgData = self.cellModel.logos.light, let image = UIImage(data: imgData) {
      self.logo.image = image
    }
    
    // title
    let titleLabelSize = self.getTitleLabelSize()
    self.title.frame = CGRect(x:      self.logo.frame.maxX + LeaguesConstants.leaguesTableLabelsInset,
                              y:      inset,
                              width:  titleLabelSize.width,
                              height: titleLabelSize.height)
    self.title.text = self.cellModel.title
    
    // abbr
    self.abbreviation.frame = CGRect(x:      self.logo.frame.maxX + LeaguesConstants.leaguesTableLabelsInset,
                                     y:      self.title.frame.maxY,
                                     width:  titleLabelSize.width,
                                     height: self.frame.height - 2 * inset - self.title.frame.height)
    self.abbreviation.text = self.cellModel.abbr
    
  }
  
  
  private func getTitleLabelSize() -> CGSize {
    let inset = LeaguesConstants.leaguesTeableCellInsets
    
    var titleLabelHeight = self.frame.height / 2 - inset
    let titleLabelWidth = self.frame.width - self.logo.frame.width - LeaguesConstants.leaguesTableLabelsInset
    let titleTextWidth = self.cellModel.title.calculateWidthtBy(font: .titleFont())
    if titleTextWidth > titleLabelWidth {
      titleLabelHeight += 20
    }
    
    return CGSize(width: titleLabelWidth, height: titleLabelHeight)
  }
  
}
