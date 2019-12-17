//
//  MarvelsCollectionViewCell.swift
//  Fintonic
//
//  Created by Juan Gerardo Cruz on 12/16/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//

import UIKit

class MarvelsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var realNameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    
    var marvel: Marvels? {
        didSet {
            guard let heroe = marvel else { return }
            nameLabel.text = heroe.name
            realNameLabel.text = heroe.realName
            photoImageView.downloadImageFromServer(link: heroe.photo)
            heightLabel.text = heroe.height
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 13
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor

        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 2.0, height: 4.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        photoImageView.layer.cornerRadius = 10
    }
    
    
}
