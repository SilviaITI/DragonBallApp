//
//  DetailTransformationViewController.swift
//  DragonBall_SilviaCasanova
//
//  Created by Silvia Casanova Martinez on 27/9/23.
//

import UIKit

class DetailTransformationViewController: UIViewController {
    // MARK: - Properties
    public var transformation:Transformation
    
    // MARK: - Outlets
    @IBOutlet weak var transformationDescritpion: UILabel!
    @IBOutlet weak var transformationImage: UIImageView!
    
    // MARK: - Initializers
    init(transformation: Transformation) {
        self.transformation = transformation
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = transformation.name
        transformationDescritpion.text = transformation.description
        transformationImage.setImage(for: transformation.photo)
        
    }
}
