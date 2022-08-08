//
//  Config.swift
//  InfoTechInterview
//
//  Created by Ilya Senchukov on 08.08.2022.
//

import Foundation

enum Configuration {

	static var apiKey: String {
		guard let value = try? Self.value(for: "API_KEY") else {
			fatalError("API_KEY is missing")
		}
		return value
	}
}

extension Configuration {

	enum Error: Swift.Error {
		case missingKey, invalidValue
	}

	private static func value(for key: String) throws -> String {
		guard let object = Bundle.main.object(forInfoDictionaryKey: key) else {
			throw Error.missingKey
		}

		guard let value = object as? String else {
			throw Error.invalidValue
		}

		return value
	}

}
