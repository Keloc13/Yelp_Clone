//
//  BusinessCell.swift
//  Yelp
//
//  Created by Kevin Nguyen on 2/13/18.
//  Copyright © 2018 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {

    @IBOutlet weak var CategoryLabel: UILabel!
    @IBOutlet weak var FoodImageView: UIImageView!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var DistanceLabel: UILabel!
    @IBOutlet weak var LocationLabel: UILabel!
    @IBOutlet weak var ReviewsLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    
    var business: Business! {
        didSet {
            TitleLabel.text = business.name
            FoodImageView.setImageWith(business.imageURL!)
            CategoryLabel.text = business.categories
            DistanceLabel.text = business.distance
            LocationLabel.text = business.address
            ReviewsLabel.text = "\(business.reviewCount!) Reviews"
            ratingImageView.setImageWith(business.ratingImageURL!)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        FoodImageView.layer.cornerRadius = 3
        FoodImageView.clipsToBounds = true
        
        TitleLabel.preferredMaxLayoutWidth = TitleLabel.frame.size.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       // TitleLabel.preferredMaxLayoutWidth = TitleLabel.frame.size.width
    }//when the parent change the dimension, this happens.
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
