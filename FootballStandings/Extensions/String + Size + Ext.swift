//
//  String + Height + Ext.swift
//  psychotech
//
//  Created by BolKab on 20.11.2021.
//  Copyright © 2021 BolKab. All rights reserved.
//


import UIKit


extension String {
  
  // Расчет высоты контента при заданной ширине и шрифте
  func calculateHeightBy(width: CGFloat, font: UIFont) -> CGFloat {
    
    let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
    
    let size = self.boundingRect(with:       textSize,
                                 options:    .usesLineFragmentOrigin,
                                 attributes: [NSAttributedString.Key.font : font],
                                 context:    nil)
    
    return size.height
  }
  
  
  // Расчет ширины текста при заданном шрифте
  func calculateWidthtBy(font: UIFont) -> CGFloat {
    
     let itemSize = (self as NSString).size(withAttributes: [NSAttributedString.Key.font : font]) as CGSize
    
    return itemSize.width
  }
  
}



