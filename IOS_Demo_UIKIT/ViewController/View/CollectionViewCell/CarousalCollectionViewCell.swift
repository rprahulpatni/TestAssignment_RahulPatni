//
//  CarousalCollectionViewCell.swift
//  IOS_Demo_UIKIT
//

import UIKit

class CarousalCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.imgView.layer.cornerRadius = 10
        self.imgView.layer.masksToBounds = true
        self.imgView.contentMode = .scaleToFill
    }
}
