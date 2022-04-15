//
//  CharacterViewCell.swift
//  AppricotTsetProject
//
//  Created by Roman Efimov on 14.04.2022.
//


import UIKit

class CharacterViewCell: UITableViewCell {

    @IBOutlet weak var avatarImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImage.layer.cornerRadius = 15
    }
    
}
