//
//  MocaPlusCafeCell.swift
//  Moca-iOS
//
//  Created by soomin on 2018. 12. 27..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class MocaPlusContentCell: UITableViewCell {
    @IBOutlet weak var cafeLocationLabel: UILabel!
    @IBOutlet weak var cafeNameLabel: UILabel!
    @IBOutlet weak var smallNameLabel: UILabel!
    @IBOutlet weak var cafeContentsLabel: UILabel!
    @IBOutlet weak var cafeMenuImageCollectionView: UICollectionView!

    var mocaPlusContent: MocaPlusContent? {
        didSet { setUpData() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
    }
    
    private func setUpData() {
        guard let mocaPlusContent = mocaPlusContent else { return }
        cafeNameLabel.text = mocaPlusContent.cafeName
        smallNameLabel.text = mocaPlusContent.cafeName
        cafeLocationLabel.text = mocaPlusContent.addressDistrictName
        cafeContentsLabel.applyLineSpacing(lineSpacing: 12, text: mocaPlusContent.plusContentsContent)
    }
    
    private func setUpCollectionView() {
        self.cafeMenuImageCollectionView.delegate = self
        self.cafeMenuImageCollectionView.dataSource = self
    }
}

extension MocaPlusContentCell : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let mocaPlusContent = mocaPlusContent else { return 0 }
        return mocaPlusContent.contentImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        guard let image = mocaPlusContent?.contentImages[indexPath.item] else { return cell }
        
        if let imageCell = cafeMenuImageCollectionView.dequeueReusableCell(withReuseIdentifier: "MocaPlusCafeImageCell", for: indexPath) as? MocaPlusCafeImageCell {
            imageCell.defaultImageView.imageFromUrl(image.plusDefaultImgURL, defaultImgPath: "")
            imageCell.cafeMenuImageView.imageFromUrl(image.plusTaggingImgURL, defaultImgPath: "")
            imageCell.cafeMenuImageView.isHidden = true
            cell = imageCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? MocaPlusCafeImageCell {
            cell.touch = !cell.touch
        }
    }
}
