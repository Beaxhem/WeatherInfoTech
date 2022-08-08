//
//  CityCell.swift
//  InfoTechInterview
//
//  Created by Ilya Senchukov on 08.08.2022.
//

import UIKit

class CityCell: UICollectionViewCell {

	@IBOutlet weak var cityNameLabel: UILabel!

	override func awakeFromNib() {
		super.awakeFromNib()
		layer.cornerRadius = 10
	}

	func update(city: City) {
		cityNameLabel.text = city.name
	}

}
