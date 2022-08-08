//
//  Marker.swift
//  InfoTechInterview
//
//  Created by Ilya Senchukov on 08.08.2022.
//

import MapKit

class Marker: NSObject, MKAnnotation {
	let coordinate: CLLocationCoordinate2D

	init(coordinates: Coordinates) {
		self.coordinate = .init(latitude: coordinates.latitude,
								longitude: coordinates.longitude)
		super.init()
	}
}
