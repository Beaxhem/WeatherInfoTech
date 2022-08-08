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

	private var url: URL? {
		let coords = city.coordinates
		let apiKey = "1074fc90423e5375fce252f0822327e6"
		return URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(coords.latitude)&lon=\(coords.longitude)&units=metric&appid=\(apiKey)")
	}

	init(city: City) {
		self.city = city
		fetchWeatherDetails { [weak self] weatherData in
			self?.weatherData = weatherData
		}
	}

	func fetchWeatherDetails(completion: @escaping (WeatherData) -> Void) {
		guard let url = url else {
			return
		}
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			if let error = error {
				print(error)
				return
			}

			guard let response = response as? HTTPURLResponse,
				  response.statusCode == 200 else {
				return
			}

			guard let data = data else { return }
			do {
				let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
				completion(weatherData)
			} catch {
				print(error)
			}
		}
		task.resume()
	}

}
