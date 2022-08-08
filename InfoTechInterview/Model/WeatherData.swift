//
//  WeatherData.swift
//  InfoTechInterview
//
//  Created by Ilya Senchukov on 08.08.2022.
//

import Foundation

struct WeatherData: Decodable {

	var description: String? { weather.first?.main }

	var weather: [Weather]
	var main: Main
	var wind: Wind

}

extension WeatherData {

	struct Weather: Decodable {
		var main: String
	}

}

extension WeatherData {

	struct Main: Decodable {
		var temperature: Float
		var minTemperature: Float
		var maxTemperature: Float
		var humidity: Float

		enum CodingKeys: String, CodingKey {
			case temperature = "temp"
			case minTemperature = "temp_min"
			case maxTemperature = "temp_max"
			case humidity
		}
	}

}

extension WeatherData {

	struct Wind: Decodable {
		var speed: Float
	}

}
