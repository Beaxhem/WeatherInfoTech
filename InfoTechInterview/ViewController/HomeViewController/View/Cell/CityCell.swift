//
//  CityCell.swift
//  InfoTechInterview
//
//  Created by Ilya Senchukov on 08.08.2022.
//

import UIKit

class CityCell: UICollectionViewCell {

	@IBOutlet weak var cityNameLabel: UILabel!
	@IBOutlet weak var imageView: UIImageView!

	var image: UIImage? {
		didSet {
			imageView.image = image
		}
	}

	override func awakeFromNib() {
		super.awakeFromNib()
		layer.cornerRadius = 10
	}

	func update(city: City) {
		cityNameLabel.text = city.name
	}

}
