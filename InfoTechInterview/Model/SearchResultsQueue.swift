//
//  SearchResultsQueue.swift
//  InfoTechInterview
//
//  Created by Ilya Senchukov on 08.08.2022.
//

import Foundation

class SearchResultsQueue {

	private let operationQueue: OperationQueue

	init() {
		operationQueue = OperationQueue()
		operationQueue.maxConcurrentOperationCount = 1
	}

	func add(_ action: @escaping () -> Void) {
		operationQueue.cancelAllOperations()
		operationQueue.addOperation {
			action()
		}
	}

}
