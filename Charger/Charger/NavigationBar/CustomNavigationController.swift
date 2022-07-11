//
//  CustomNavigationController.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-11.
//

import UIKit

class CustomNavigationController: UINavigationController
{
    // MARK: Navigation Controller Life Cycle
    override func viewDidLoad()
    {
       super.viewDidLoad()
       setNavBar()
    }

    // MARK: Methods
    func setNavBar()
    {
       // set font for title
      self.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Themes.fontBold, NSAttributedString.Key.foregroundColor: Themes.colorSolidWhite ]
    
      // set bar background Color
      self.navigationBar.backgroundColor = Themes.colorCharcoal
  
       // set font for navigation bar buttons
      UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: Themes.fontRegular], for: UIControl.State.normal)
    }
}
