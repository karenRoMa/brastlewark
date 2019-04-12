//
//  MainTableViewCell.swift
//  Brastlewark
//
//  Created by Karen Rodriguez on 4/8/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    // MARK: - Singleton Properties -
    
    static let nibName: String = "MainTableViewCell"
    static let reuseIdentifier: String = "MainTableViewCellIdentifier"
    static let rowHeight: CGFloat = 200.0
    
    // MARK: - IBOutlets -
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var gnomeImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var hairColorLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Stored Properties -
    var gnome: Gnome!
    let imageCache = NSCache<NSString, UIImage>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        mainView.round(with: 5.0)
        gnomeImage.round()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell() {
        nameLabel.text = gnome.name
        ageLabel.text = "\(gnome.age)"
        hairColorLabel.text = gnome.hair_color
        URL(string: gnome.thumbnail)?.downloadImage(imageCache: imageCache, completion: { [weak self] (image, error) in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                if let validImage = image {
                    self?.gnomeImage.image = validImage
                } else {
                    self?.gnomeImage.image = UIImage(named: "gnome")
                }
            }
        })
    }
    
}
