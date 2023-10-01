//
//  CustomCellTableViewCell.swift
//  DragonBall_SilviaCasanova
//
//  Created by Silvia Casanova Martinez on 24/9/23.
//

import UIKit

final class CustomCellTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "CustomCellTableViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var customView: UIView!
    
    // MARK: - Public Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        customView.layer.borderWidth = 3.0
        customView.layer.borderColor = UIColor.gray.cgColor
        customView.layer.cornerRadius = 20.0
        heroImage.layer.cornerRadius = 20.0
        
    }
    
    // Function to configure custom cell content
    func configure(with hero: Hero) {
        nameLabel.text = hero.name
        heroImage.setImage(for: hero.photo)
    }
}
