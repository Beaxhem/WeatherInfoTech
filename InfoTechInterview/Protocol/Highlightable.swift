//
//  Highlightable.swift
//  InfoTechInterview
//
//  Created by Ilya Senchukov on 08.08.2022.
//

import UIKit

protocol Highlightable: UIView {
	func highlight()
	func unhighlight()
}

extension Highlightable {

	func highlight() {
		animateChanges { [weak self] in
			self?.transform = .init(scaleX: 0.95, y: 0.95)
		}
	}

	func unhighlight() {
		animateChanges { [weak self] in
			self?.transform = .identity
		}
	}

	func animateChanges(_ action: @escaping () -> Void) {
		UIView.animate(withDuration: 0.1,
					   delay: 0,
					   options: [.allowUserInteraction, .beginFromCurrentState]) {
			action()
		}
	}

}
