//
//  UIImageView.swift
//  MyMealPlanner
//  RoundedImage
//
//  Created by Marissa Homer on 2/1/24.
//

import UIKit

extension UIImageView {
    func roundedImage() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 4
    }
}
