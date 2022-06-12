//
//  SeasonsCell.swift
//  FootballStandings
//
//  Created by BolKab on 08.06.2022.
//

import UIKit


final class SeasonsCell: UITableViewCell {
  
  // MARK: Interface
  private let title: UILabel = {
    let label = UILabel()
    label.font = .titleFont()
    label.textColor = .black
    label.numberOfLines = 0
    label.backgroundColor = .clear
    
    return label
  }()
  
  private let dateLabel: UILabel = {
    let label = UILabel()
    label.font = .subTitleFont()
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
  
  
  // MARK: Variables
  static let reuseId = "SeasonsCell"
  
  private var cellModel: SeasonTableModelProtocol!
  
  
  // MARK: Methods
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.backgroundColor = .clear
    
    self.addSubviews()
  }
  
  
  override func prepareForReuse() {
    super.prepareForReuse()
    self.title.text = ""
    self.dateLabel.text = ""
    self.abbreviation.text = ""
  }
}

// MARK: Set Cell
extension SeasonsCell: CellProtocol {
  
  func setCell(model: SeasonTableModelProtocol) {
    
    self.cellModel = model
    
    // Interface
    self.overlayInterface()
  }
}


// MARK: Layout
extension SeasonsCell {
  
  private func addSubviews() {
    self.addSubview(self.title)
    self.addSubview(self.dateLabel)
    self.addSubview(self.abbreviation)
  }
  
  
  private func overlayInterface() {
    
    let inset = LeaguesConstants.leaguesTeableCellInsets
    
    // title
    let titleLabelSize = self.getTitleLabelSize()
    self.title.frame = CGRect(x:      0,
                              y:      inset / 2,
                              width:  titleLabelSize.width,
                              height: titleLabelSize.height)
    self.title.text = self.cellModel.name
    
    let freeHeight = self.frame.height - (self.title.frame.height + inset)
    
    // dateLabel
    self.dateLabel.frame = CGRect(x:      0,
                                  y:      self.title.frame.maxY + inset / 2,
                                  width:  titleLabelSize.width,
                                  height: freeHeight / 2 - inset / 2)
    self.dateLabel.text = "\(self.cellModel.startDate) - \(self.cellModel.endDate)"
    
    // abbr
    self.abbreviation.frame = CGRect(x:      0,
                                     y:      self.dateLabel.frame.maxY + inset / 2,
                                     width:  titleLabelSize.width,
                                     height: freeHeight / 2 - inset)
    self.abbreviation.text = self.cellModel.abbr
    
  }
  
  
  private func getTitleLabelSize() -> CGSize {
    let inset = LeaguesConstants.leaguesTeableCellInsets
    
    var titleLabelHeight = self.frame.height / 3 - inset
    let titleLabelWidth = self.frame.width
    let titleTextWidth = self.cellModel.name.calculateWidthtBy(font: .titleFont())
    if titleTextWidth > titleLabelWidth {
      titleLabelHeight += 20
    }
    
    return CGSize(width: titleLabelWidth, height: titleLabelHeight)
  }
  
}


