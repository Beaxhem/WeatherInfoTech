//
//  HomeViewModel.swift
//  InfoTechInterview
//
//  Created by Ilya Senchukov on 08.08.2022.
//

import Foundation

protocol HomeViewModel: ViewModel {
	var isLoaded: Bool { get }
	var cities: [City] { get }
	var query: String { get set }
}
