//
//  RankingCafeCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 26..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class RankingCafeCell: UICollectionViewCell {
    @IBOutlet var rankNumLabel: UILabel!
    @IBOutlet var cafeImageView: UIImageView!
    @IBOutlet var cafeNameLabel: UILabel!
    @IBOutlet var cafeAddressLabel: UILabel!
    
    var cafe: RankingCafe? {
        didSet { setUpData() }
    }
    
    private func setUpData() {
        guard let cafe = cafe else { return }
        cafeNameLabel.text = cafe.cafeName
        cafeAddressLabel.text = cafe.addressDistrictName
        cafeImageView.imageFromUrl(cafe.cafeMenuImgURL, defaultImgPath: "")
    }
    
}
