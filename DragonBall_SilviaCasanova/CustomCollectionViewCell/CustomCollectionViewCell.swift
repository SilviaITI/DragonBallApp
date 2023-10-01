//
//  CustomCollectionViewCell.swift
//  DragonBall_SilviaCasanova
//
//  Created by Silvia Casanova Martinez on 27/9/23.
//

import UIKit

final class CustomCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let  identifier = "CustomCollectionViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var transformationTitleLabel: UILabel!
    @IBOutlet weak var transformationImageView: UIImageView!
    @IBOutlet weak var customView: UIView!
   
    // MARK: - Public Methods
    
    // Function to configure custom cell appearance
    override func awakeFromNib() {
        customView.layer.borderWidth = 3.0
        customView.layer.borderColor = UIColor.gray.cgColor
        customView.layer.cornerRadius = 20.0
        transformationImageView.layer.cornerRadius = 20.0
        super.awakeFromNib()

    }
    
    // Function to configure custom cell content
    func configure(with transfomation: Transformation) {
        transformationTitleLabel.text = transfomation.name
        transformationImageView.setImage(for: transfomation.photo)
    }
}
