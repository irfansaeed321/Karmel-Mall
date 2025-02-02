//
//  AddDetailCell.swift
//  AdForest
//
//  Created by Apple on 11/13/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import Alamofire
import ImageSlideshow

class AddDetailCell: UITableViewCell {
    
    @IBOutlet weak var viewAddApproval: UIView!
    @IBOutlet weak var lblAddApproval: UILabel!
    @IBOutlet weak var viewFeaturedAdd: UIView!
    @IBOutlet weak var lblFeaturedAdd: UILabel!
    @IBOutlet weak var buttonFeatured: UIButton! {
        didSet {
            if let mainColor = UserDefaults.standard.string(forKey: "mainColor"){
                buttonFeatured.backgroundColor = Constants.hexStringToUIColor(hex: mainColor)
            }
        }
    }
    @IBOutlet weak var slideshow: ImageSlideshow!
    @IBOutlet weak var lblFeatured: UILabel!
    @IBOutlet weak var oltDirection: UIButton!
    @IBOutlet weak var lblTimer: UILabel! {
        didSet {
            lblTimer.isHidden = true
            lblTimer.backgroundColor = Constants.hexStringToUIColor(hex: "90000000")
        }
    }
    
    //MARK:- Properties
    
    var btnMakeFeature: (()->())?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var imagesArray = [AddDetailImage]()
    var objImage : AddDetailImage?
    var isFeature = false
    var featureText = ""
    var stringValue = ""
    var btnDirectionAction: (()->())?
    var sourceImages = [InputSource]()
    var localImages = [String]()
    var tapAction: (()->())?
    
    //MARK:- Properties
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func imageSliderSetting() {
        for image in localImages {
            let alamofireSource = AlamofireSource(urlString: image.encodeUrl())!
            sourceImages.append(alamofireSource)
        }
        slideshow.backgroundColor = UIColor.white
        slideshow.slideshowInterval = 5.0
        slideshow.pageControlPosition = PageControlPosition.insideScrollView
        slideshow.pageControl.currentPageIndicatorTintColor = UIColor.white
        slideshow.pageControl.pageIndicatorTintColor = UIColor.lightGray
        slideshow.contentScaleMode = UIViewContentMode.scaleAspectFit
        
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        slideshow.activityIndicator = DefaultActivityIndicator()
        slideshow.currentPageChanged = { page in
        }
        
        slideshow.setImageInputs(sourceImages)
        if #available(iOS 13.0, *) {
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
            slideshow.addGestureRecognizer(recognizer)
                   sourceImages.removeAll()
        } else {
            // Fallback on earlier versions
            tapAction?()
        }
    }
    
   
    @available(iOS 13.0, *)
    @objc func didTap() {
        tapAction?()
    }
    
    //MARK:- IBActions
    @IBAction func actionFeatured(_ sender: UIButton) {
        self.btnMakeFeature?()
    }
    
    
    @IBAction func actionDirection(_ sender: Any) {
        self.btnDirectionAction?()
    }
}
