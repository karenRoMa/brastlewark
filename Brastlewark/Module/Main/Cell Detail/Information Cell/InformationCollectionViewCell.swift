//
//  InformationCollectionViewCell.swift
//  Brastlewark
//
//  Created by Karen Rodriguez on 4/9/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import UIKit

class InformationCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Singleton Properties -
    
    static let nibName: String = "InformationCollectionViewCell"
    static let reuseIdentifier: String = "InformationCollectionViewCellIdentifier"

    // MARK: - IBOutlets -
    
    @IBOutlet weak var textLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.round(with: 5.0)
    }

}
