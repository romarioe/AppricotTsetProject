//
//  DeteilViewController.swift
//  AppricotTsetProject
//
//  Created by Roman Efimov on 14.04.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var speciesTitle: UILabel!
    @IBOutlet weak var genderTitle: UILabel!
    @IBOutlet weak var statusTitle: UILabel!
    @IBOutlet weak var locationTitle: UILabel!
    @IBOutlet weak var episodesCountTitle: UILabel!
    
    @IBOutlet weak var episodesTableView: UITableView!
    
    
    let networkService = NetworkService()
    var id: Int?
    var characterName = ""
    var characterDetail: DetailCharacterModel?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = characterName
        avatarImage.layer.cornerRadius = 15
        fetchDetailData()
    }
    
    
    
    
    func fetchDetailData(){
        guard let id = id else {return}
        
        networkService.fetchDetailCharacter(id: id) { characterDetail in
            guard let characterDetail = characterDetail else {
                return
            }
            
            self.characterDetail = characterDetail
            self.updateUI(with: characterDetail)
        }
    }
    
    
    
    func updateUI(with characterDetail: DetailCharacterModel){
        DispatchQueue.main.async {
        
            self.navigationItem.title = characterDetail.name
            self.speciesTitle.text = characterDetail.species
            self.genderTitle.text = characterDetail.gender
            self.statusTitle.text = characterDetail.status
            self.locationTitle.text = characterDetail.location.name
            self.episodesCountTitle.text = "Кол-во эпизодов: "
            + String(characterDetail.episode.count)
            
            self.episodesTableView.reloadData()
        }
        
        if let avatarURL = URL(string: characterDetail.image) {
            self.avatarImage.download(from: avatarURL)
        } else{
            self.avatarImage.image = UIImage(named: "person.fill")
        }
    }
    
}


extension DetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterDetail?.episode.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = episodesTableView.dequeueReusableCell(withIdentifier: "episodesCell", for: indexPath)
        cell.textLabel?.text = characterDetail?.episode[indexPath.row]
        return cell
    }
    
    
    
    
    
}
