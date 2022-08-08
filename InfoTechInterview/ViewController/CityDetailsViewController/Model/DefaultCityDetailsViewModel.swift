//
//  DefaultCityDetailsViewModel.swift
//  InfoTechInterview
//
//  Created by Ilya Senchukov on 08.08.2022.
//

import Foundation

class DefaultCityDetailsViewModel: CityDetailsViewModel {

	var city: City

	var weatherData: WeatherData? = nil {
		didSet {
			bindToController()
		}
	}

	var bindToController: () -> Void = {}

	init(city: City) {
		self.city = city
		fetchWeatherDetails { [weak self] weatherData in
			self?.weatherData = weatherData
		}
	}

	func fetchWeatherDetails(completion: @escaping (WeatherData) -> Void) {
		let coords = city.coordinates
		let apiKey = "1074fc90423e5375fce252f0822327e6"
		guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(coords.latitude)&lon=\(coords.longitude)&appid=\(apiKey)") else {
			return
		}

		URLSession.shared.dataTask(with: url) { data, response, error in
			if let error = error {
				print(error)
				return
			}

			guard let response = response as? HTTPURLResponse,
				  response.statusCode == 200 else {
				return
			}

			guard let data = data,
				  let weatherData = try? JSONDecoder().decode(WeatherData.self, from: data) else {
				return
			}

			completion(weatherData)
		}
	}

}
