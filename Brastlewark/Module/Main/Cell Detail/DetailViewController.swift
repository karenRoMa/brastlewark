//
//  DetailViewController.swift
//  Brastlewark
//
//  Created by Karen Rodriguez on 4/9/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - IBOutlets -
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var hairColorLabel: UILabel!
    @IBOutlet weak var professionsCollectionView: UICollectionView!
    @IBOutlet weak var friendsCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Stored Properties -
    
    var gnome: Gnome!
    var imageCache = NSCache<NSString, UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollections()
        configureDetail()
    }
    
    func configureCollections() {
        professionsCollectionView.dataSource = self
        friendsCollectionView.dataSource = self
        professionsCollectionView.delegate = self
        friendsCollectionView.delegate = self
        professionsCollectionView.register(UINib(nibName: InformationCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: InformationCollectionViewCell.reuseIdentifier)
        friendsCollectionView.register(UINib(nibName: InformationCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: InformationCollectionViewCell.reuseIdentifier)
    }
    
    func configureDetail(){
        nameLabel.text = gnome.name
        ageLabel.text = "\(gnome.age)"
        hairColorLabel.text = gnome.hair_color
        heightLabel.text = "\(gnome.height)"
        weightLabel.text = "\(gnome.weight)"
        URL(string: gnome.thumbnail)?.downloadImage(imageCache: imageCache, completion: { [weak self] (image, error) in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                if let validImage = image {
                    self?.imageView.image = validImage
                } else {
                    self?.imageView.image = UIImage(named: "gnome")
                }
            }
        })
    }
    
    // MARK: - IBActions -
    
    @IBAction func closeDetail(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - Collection View DataSource & Delegate -

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == professionsCollectionView {
            return gnome.professions.count
        } else {
            return gnome.friends.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InformationCollectionViewCell.reuseIdentifier, for: indexPath) as! InformationCollectionViewCell
        if collectionView == professionsCollectionView {
            cell.textLabel.text = gnome.professions[indexPath.row]
        } else {
            cell.textLabel.text = gnome.friends[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90.0, height: 80.0)
    }
}
