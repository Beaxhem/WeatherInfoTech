//
//  Marker.swift
//  InfoTechInterview
//
//  Created by Ilya Senchukov on 08.08.2022.
//

import MapKit

class Marker: NSObject, MKAnnotation {
	var title: String?
	let coordinate: CLLocationCoordinate2D

	init(city: City) {
		self.title = city.name
		let coordinates = city.coordinates
		self.coordinate = .init(latitude: coordinates.latitude,
								longitude: coordinates.longitude)
		super.init()
	}
}
