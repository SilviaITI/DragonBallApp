//
//  CollectionViewController.swift
//  DragonBall_SilviaCasanova
//
//  Created by Silvia Casanova Martinez on 27/9/23.
//

import UIKit

class CollectionViewController: UIViewController {
    
    
    // MARK: - Properties
    public var transformations:[Transformation] = []
    
    // MARK: - Outlets
    @IBOutlet weak var collectionViewTransformations: UICollectionView!
    
    // MARK: - LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        
    }
    // MARK: - Public Methods
// Function settings for ViewDidLoad
func setView() {
    title = "Transformaciones"
    navigationItem.largeTitleDisplayMode = .always
    navigationController?.navigationBar.prefersLargeTitles = true
    collectionViewTransformations.dataSource = self
    collectionViewTransformations.delegate = self
    collectionViewTransformations.register(
        UINib(nibName: "CustomCollectionViewCell", bundle: nil),
        forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
}
}

// MARK:- Extensions UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension CollectionViewController: UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        transformations.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard  let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath)
                as? CustomCollectionViewCell else {
            
            return UICollectionViewCell()
        }
        let transformation = transformations[indexPath.row]
        cell.configure(with: transformation)
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width / 3, height:UIScreen.main.bounds.width / 3 )
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumLineSpacing = 40      }
        return 40
    }
    
    
}
//MARK:- Extensions UICollectionViewDelegate
extension CollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let transformation = transformations[indexPath.row]
        let detailTransformationViewController = DetailTransformationViewController(transformation: transformation)
        detailTransformationViewController.transformation = transformation
        
        navigationController?.pushViewController(detailTransformationViewController, animated: true)
    }
    
}

