//
//  GradientView.swift
//  InfoTechInterview
//
//  Created by Ilya Senchukov on 08.08.2022.
//

import UIKit

class GradientView: UIView {

	override class var layerClass: AnyClass { CAGradientLayer.self }

	var colors: [UIColor] = [.clear, .black] {
		didSet {
			setupView()
		}
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}

	func setupView() {
		guard let layer = layer as? CAGradientLayer else { return }
		layer.colors = colors.map { $0.cgColor }
		layer.locations = [0, 1]
	}

}
