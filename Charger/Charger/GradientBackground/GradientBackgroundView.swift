//
//  GradientBackgroundView.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-11.
//

import UIKit
// With this class we will set the background of the app
class GradientBackgroundView: UIView {
  override func draw(_ rect: CGRect) {
    let colorBottom = Themes.colorDark.cgColor
    let colorTop = Themes.colorDark_2.cgColor
    let gradient: CAGradientLayer = CAGradientLayer()
    gradient.type = .axial
    gradient.frame = self.bounds // get our view frame bounds
    
    gradient.colors = [colorTop,colorBottom,colorBottom,colorBottom] // as the bottom color of the gradient get more space than top color of the gradient view I added bottom color more than once
    gradient.zPosition = -1 // place the created color scheme back in the view
    layer.addSublayer(gradient) // place created gradient color to our view
  }
  
}
