//
//  CheckBox.swift
//  AdForest
//
//  Created by Furqan Nadeem on 30/01/2019.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
class CheckBox: UIButton {
    // Images
    let checkedImage = UIImage(named: "check")! as UIImage
    let uncheckedImage = UIImage(named: "uncheck")! as UIImage
    
    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: UIControl.State.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
