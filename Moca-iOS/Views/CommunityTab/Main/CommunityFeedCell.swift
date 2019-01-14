//
//  CommunityFeedCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 26..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class CommunityFeedCell: UITableViewCell {
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var likeCntLabel: UILabel!
    @IBOutlet weak var commentCntLabel: UILabel!
    @IBOutlet weak var cafeNameLabel: UILabel!
    @IBOutlet weak var cafeAddressLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var reviewContentLabel: UILabel!
    @IBOutlet weak var cntBackgroundView: UIView!
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var imageCntLabel: UILabel!
    weak var delegate: ListViewCellDelegate?
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoic2VldW5pIiwiaXNzIjoiRG9JVFNPUFQifQ.56TYkh--ZSO7duJvdVLf-BOgFBPCG9fdDRGUGTmtC68"
    var review: CommunityReview? {
        didSet { setUpData() }
    }
    var images: [ReviewImage]? {
        didSet { setUpImage() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
        setUpView()
        registerGesture()
    }
    
    private func setUpImage() {
        imageCollectionView.reloadData()
        if let images = images {
            if images.count <= 1 {
                cntBackgroundView.isHidden = true
            } else {
                cntBackgroundView.isHidden = false
                imageCntLabel.text = "1/\(images.count)"
            }
            
        }
    }
    
    private func setUpData() {
        guard let review = review else { return }
        nameLabel.text = review.userName
        cafeNameLabel.text = review.cafeName
        cafeAddressLabel.text = review.cafeAddress
        likeCntLabel.text = "\(review.likeCount)"
        commentCntLabel.text = "\(review.commentCount)"
        reviewContentLabel.text = review.reviewTitle
        timeLabel.text = review.time
        
        images = review.image
        
        profileImageView.imageFromUrl(review.userImgURL, defaultImgPath: "commonDefaultimage")
        if review.like {
            likeButton.setImage(#imageLiteral(resourceName: "commonHeartRed"), for: .normal)
        } else {
            likeButton.setImage(#imageLiteral(resourceName: "commonHeartBlank"), for: .normal)
        }
    }
    
    private func setUpCollectionView() {
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.isPagingEnabled = true
    }
    
    private func setUpView() {
        profileImageView.applyRadius(radius: 20)
        cntBackgroundView.applyBorder(width: 0.5, color: #colorLiteral(red: 0.5141925812, green: 0.5142051578, blue: 0.5141984224, alpha: 1))
        cntBackgroundView.applyRadius(radius: cntBackgroundView.frame.height/2)
        
    }
    
    private func initReviewData() {
        guard let review = review else { return }
        CommunityReviewDetailService.shareInstance.getReviewDetail(reviewId: review.reviewID, token: token, completion: { (res) in
            self.review = res
            print("리뷰 조회 성공")
        }) { (err) in
            print("리뷰 조회 실패")
        }
    }
    
    @IBAction func likeAction(_ sender: UIButton) {
        guard let review = review else { return }
        CommunityReviewLikeService.shareInstance.postLike(reviewId: review.reviewID, token: token, completion: { (message) in
            self.initReviewData()
            print("좋아요 취소 성공")
        }) { (err) in
            print("좋아요 취소 실패")
        }
    }
    
    @IBAction func goToCommentAction(_ sender: UIButton) {
        guard let review = review else { return }
        if let vc = UIStoryboard(name: "CommunityTab", bundle: nil).instantiateViewController(withIdentifier: "CommunityContentVC") as? CommunityContentVC {
            vc.reviewId = review.reviewID
            delegate?.goToViewController(vc: vc)
        }
    }
    
    @IBAction func moreNotifyAction(_ sender: UIButton) {
        delegate?.showActionSheet()
    }
    
    @IBAction func moreLookAction(_ sender: UIButton) {
        guard let review = review else { return }
        if let vc = UIStoryboard(name: "CommunityTab", bundle: nil).instantiateViewController(withIdentifier: "CommunityContentVC") as? CommunityContentVC {
            vc.reviewId = review.reviewID
            delegate?.goToViewController(vc: vc)
        }
    }
    
    private func registerGesture() {
        let searchTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(goToUserFeedAction(_:)))
        profileImageView.addGestureRecognizer(searchTapGestureRecognizer)
    }
    
    @objc func goToUserFeedAction(_: UIImageView) {
        guard let review = review else { return }
        if let vc = UIStoryboard(name: "CommunityTab", bundle: nil).instantiateViewController(withIdentifier: "CommunityUserFeedVC") as? CommunityUserFeedVC {
            vc.userId = review.userID
            delegate?.goToViewController(vc: vc)
        }
    }
}

extension CommunityFeedCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lenght = imageCollectionView.frame.width
        return CGSize(width: lenght, height: lenght)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let images = images else { return 0 }
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let imageCell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "CommunityContentImageCell", for: indexPath) as? CommunityContentImageCell {
            guard let images = images else { return cell }
            imageCell.image = images[indexPath.item]
            cell = imageCell
        }
        return cell
    }
    
}

extension CommunityFeedCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let images = images else { return }
        
        if scrollView is UICollectionView {
            let indexPath = imageCollectionView.indexPathForItem(at: scrollView.contentOffset)
            if let index = indexPath?.item {
                imageCntLabel.text = "\(index+1)/\(images.count)"
            }
        }
    }
}

