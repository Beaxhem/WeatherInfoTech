//
//  CityDetailsViewModel.swift
//  InfoTechInterview
//
//  Created by Ilya Senchukov on 08.08.2022.
//

import Foundation

protocol CityDetailsViewModel: ViewModel {
	var city: City { get }
	var weatherData: WeatherData? { get }
}
