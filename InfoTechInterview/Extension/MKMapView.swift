//
//  MKMapView.swift
//  InfoTechInterview
//
//  Created by Ilya Senchukov on 08.08.2022.
//

import MapKit

extension MKMapView {

	func setCenter(_ coordinates: Coordinates, animated: Bool = true) {
		let location = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
		let region = MKCoordinateRegion(center: location.coordinate,
										latitudinalMeters: 20000,
										longitudinalMeters: 20000)
		setRegion(region, animated: animated)
		setCameraBoundary(.init(coordinateRegion: region), animated: false)
	}

	func removeAllAnnotations() {
		removeAnnotations(annotations)
	}

}
