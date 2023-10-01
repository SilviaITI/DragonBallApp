//
//  DetailHeroeViewController.swift
//  DragonBall_SilviaCasanova
//
//  Created by Silvia Casanova Martinez on 25/9/23.
//

import UIKit

final class DetailHeroeViewController: UIViewController {
    
    // MARK: - Properties
    private let hero: Hero
    private var transformations: [Transformation] = []
    
    // MARK: - Outlets
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var transformationButton: UIButton!
    @IBOutlet weak var favImage: UIImageView!
    
    // MARK: - Initializers
    init(hero: Hero) {
        self.hero = hero
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @IBAction func tapTransformationsButton(_ sender: Any) {
        navigateToTransformation()
        
    }
    
    // MARK: - LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    // MARK: - Public Methods
    
    // Function settings for ViewDidLoad
    func setView() {
        title = hero.name
        descriptionLabel.text = hero.description
        heroImage.setImage(for: hero.photo)
        transformationButton?.setTitle("Transformaciones", for: .normal)
        fetchTransformationsList()
        favImage.image = UIImage(systemName: hero.favorite ? "heart.fill" : "heart")
        favImage.tintColor = .red
    }
    // Function to show the spinner in the view
    func showLoading() {
        manageSpinner(inside: view, action: .add)
    }
    // Function to hide the spinner in the view
    func hideLoading() {
        DispatchQueue.main.async {
            self.manageSpinner(inside: self.view, action: .remove)
        }
    }
    
    // Function to encapsulate getHeroes function
    func fetchTransformationsList() {
        showLoading()
        NetworkModel.shared.getTransformations(
            for: hero
        ) { result in
            switch result {
            case let .success(transformations):
                DispatchQueue.main.async {
                    self.transformationButton.isHidden = transformations.isEmpty
                    self.transformations = transformations
                }
                
            case let .failure(error):
                print("Error: \(error)")
            }
            self.hideLoading()
        }
    }
    
    
    // MARK: - Navigation
    func navigateToTransformation() {
        let collectionViewController = CollectionViewController()
        collectionViewController.transformations = transformations
        self.navigationController?.pushViewController(collectionViewController, animated: true)
    }
}
