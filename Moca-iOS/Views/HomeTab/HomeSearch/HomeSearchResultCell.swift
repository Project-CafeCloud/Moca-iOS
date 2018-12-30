//
//  HomeSearchResultCell.swift
//  Moca-iOS
//
//  Created by 조수민 on 2018. 12. 28..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class HomeSearchResultCell: UITableViewCell {

    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var cafeNameLabel: UILabel!
    @IBOutlet weak var cafeLocationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        resultImageView.layer.masksToBounds = false
        resultImageView.layer.cornerRadius = resultImageView.frame.height/2
        resultImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}