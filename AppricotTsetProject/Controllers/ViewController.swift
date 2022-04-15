//
//  ViewController.swift
//  AppricotTsetProject
//
//  Created by Roman Efimov on 14.04.2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var previousPageButton: UIButton!
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var nextPageButton: UIButton!
    @IBOutlet weak var characterTableView: UITableView!
    
    let networkService = NetworkService()
    var characters: CharacterModel?
    var pagesCount = 0
    var currentPageNumber = 1
    var selectedID = 0
    var characterName = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Rick and Morty"
        
        characterTableView.register(UINib(nibName: String(describing: CharacterViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CharacterViewCell.self))
        fetchCharacters()
    }
    
  
    
    func fetchCharacters(){
        networkService.fetchCharacters(page: currentPageNumber) { characters in
            guard let characters = characters else {
                return
            }
            self.pagesCount = characters.info.pages
            self.characters = characters
            self.updateUI(with: characters)
        }
    }
    
    
    
    
    func updateUI(with characters: CharacterModel?){
        DispatchQueue.main.async {
            self.pageLabel.text = String(self.self.currentPageNumber) + " из " + String(self.pagesCount)
            self.characterTableView.reloadData()
        }
    }
    
    
    
    
    @IBAction func previousPageButtonAction(_ sender: Any) {
        if currentPageNumber > 1 {
            currentPageNumber -= 1
            fetchCharacters()
        }
    }
    
    
    
    
    @IBAction func nextPageButtonAction(_ sender: Any) {
        if currentPageNumber < pagesCount {
            currentPageNumber += 1
            fetchCharacters()
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.id = selectedID
            destinationVC.characterName = characterName
        }
    }
    
    

}



extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters?.results.count ?? 0
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = characterTableView.dequeueReusableCell(withIdentifier: String(describing: CharacterViewCell.self)) as! CharacterViewCell
        cell.nameLabel.text = characters?.results[indexPath.row].name ?? " "
        cell.speciesLabel.text = characters?.results[indexPath.row].species ?? " "
        cell.genderLabel.text = characters?.results[indexPath.row].gender ?? " "
        let imageURL = URL(string: characters?.results[indexPath.row].image ?? "")
        if let imageURL = imageURL {
            cell.avatarImage.download(from: imageURL)
        } else {
            cell.avatarImage.image = UIImage(named: "person.fill")
        }
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let characters = characters else {return}
        selectedID = characters.results[indexPath.row].id
        characterName = characters.results[indexPath.row].name
        performSegue(withIdentifier: "detailSegue", sender: nil)
    }
    
    
}

