//
//  ExecutionError+Extensions.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/2/25.
//

import ErrorWrapper

extension ExecutionError {
    static let failureInSaveAction = ExecutionError(
        title: "Save Failed",
        descrition: "Ops! Seams that an error occur when we trying to save a data. Please try again."
    )
    
    static let failureInFetchAction = ExecutionError(
        title: "Fetching Failed",
        descrition: "Seams that it wasn't possible to fetch the data from the persistence storage. Please try again or contact us."
    )
    
    static let objectNonIdentified = ExecutionError(
        title: "Object Non Identified",
        descrition: "Ops! Seams that the relationship object is not correct. Please try again or contact us."
    )
    
    static let unknownError = ExecutionError(
        title: "Unknown Error",
        descrition: "An unknown error was thrown when the an action was executed. Please try again or contact us."
    )
    
    static let indexOutsideOfLimits = ExecutionError(
        title: "Many items founded",
        descrition: "There were found a lot of items with the same id saved in the persistence storage. Please contact us or try again."
    )
}
