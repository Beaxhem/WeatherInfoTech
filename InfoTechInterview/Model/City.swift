//
//  City.swift
//  InfoTechInterview
//
//  Created by Ilya Senchukov on 08.08.2022.
//

import Foundation

struct Coordinates: Decodable {
	var longitude: Float
	var latitude: Float

	enum CodingKeys: String, CodingKey {
		case longitude = "lon", latitude = "lat"
	}
}

struct City: Decodable {
	var id: Int
	var name: String
	var state: String
	var country: String
	var coordinates: Coordinates

	enum CodingKeys: String, CodingKey {
		case id, name, state, country
		case coordinates = "coord"
	}
}
