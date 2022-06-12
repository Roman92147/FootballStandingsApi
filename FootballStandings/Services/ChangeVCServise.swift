//
//  ChangeVCServise.swift
//  FootballStandings
//
//  Created by BolKab on 07.06.2022.
//


import UIKit

protocol ChangeVCDelegate: AnyObject {
  func moveTo(viewController: UIViewController)
}


final class ChangeVCServise {
  
  static let shared = ChangeVCServise()  
  private init() {}
  
  weak var delegate: ChangeVCDelegate?
  
  func moveTo(viewController: UIViewController) {
    self.delegate?.moveTo(viewController: viewController)
  }
  
}

