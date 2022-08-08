//
//  ViewModel.swift
//  InfoTechInterview
//
//  Created by Ilya Senchukov on 08.08.2022.
//

import Foundation

protocol ViewModel {
	var bindToController: () -> () { get set }
}
