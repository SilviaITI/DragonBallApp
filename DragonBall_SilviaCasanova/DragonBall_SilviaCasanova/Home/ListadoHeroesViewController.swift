//
//  ListadoHeroesViewController.swift
//  DragonBall_SilviaCasanova
//
//  Created by Silvia Casanova Martinez on 23/9/23.
//

import UIKit

class ListadoHeroesViewController: UIViewController {
    
// MARK: - Properties
    private var heroes: [Hero] = []
    let espaceBetweenSections = 40
    
    // MARK: - Outlets
    @IBOutlet weak var dragonBallLogo: UIImageView!
    @IBOutlet weak var listadoHeroes: UITableView!
    @IBOutlet weak var logOutButton: UIBarButtonItem!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Héroes"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        listadoHeroes.dataSource = self
        listadoHeroes.delegate = self
        fetchHeroesList()
        listadoHeroes.register(
            UINib(nibName: "CustomCellTableViewCell", bundle: nil),
            forCellReuseIdentifier: CustomCellTableViewCell.identifier
        )
        self.navigationItem.hidesBackButton = true
    }
    
// MARK: - Public Methods
    // Function that receive a list of heroes
    func  fetchHeroesList() {
        showLoading()
        NetworkModel.shared.getHeroes { result in
            switch result {
            case let .success(heroes):
                self.heroes = heroes
                DispatchQueue.main.async {
                    self.listadoHeroes.reloadData()
                }
                
            case let .failure(error):
                print("Error: \(error)")
            }
            self.hideLoading()
        }
        
    }
    // Function that shows the spinner in the current view
    func showLoading() {
        manageSpinner(inside: view, action: .add)
    }
    // Function that hides the spinner from the current view
    func hideLoading() {
        DispatchQueue.main.async {
            self.manageSpinner(inside: self.view, action: .remove)
        }
    }
    func logOut() {
        LocalDataModel.deleteToken()
        navigationController?.popViewController(animated: true)
    }
    //MARK: - Navigation
    @IBAction func tapLogOut(_ sender: Any) {
      logOut()
    }
}
// MARK: - Extension UITableViewDataSource
extension ListadoHeroesViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return heroes.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {
        guard let cell = listadoHeroes.dequeueReusableCell(
            withIdentifier: CustomCellTableViewCell.identifier,
            for: indexPath)
                as? CustomCellTableViewCell else {
            return UITableViewCell()
        }
        let hero = heroes[indexPath.row]
        cell.configure(with: hero)
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(espaceBetweenSections)
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(espaceBetweenSections)
    }
}

// MARK: - Extension UITableViewDelegate
extension ListadoHeroesViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) { // para presentar la
            let hero = heroes[indexPath.row]
            let detailHeroViewController = DetailHeroeViewController(hero: hero)
            navigationController?.show(detailHeroViewController, sender: nil)
            tableView.deselectRow(at: indexPath, animated: true)
            
        }
    
}
