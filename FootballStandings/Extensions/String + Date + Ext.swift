//
//  String + Date + Ext.swift
//  FootballStandings
//
//  Created by BolKab on 08.06.2022.
//

import Foundation


extension String {
  
  func convertToViewDate() -> String {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mmZ"
    
    guard let date = dateFormatter.date(from: self) else { return "" }
    dateFormatter.dateFormat = "dd.MM.yyyy"
    
    return dateFormatter.string(from: date)
  }
  
}

