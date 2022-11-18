//
//  ViewModelType.swift
//  RxSwiftMVVM
//
//  Created by User on 28.09.2022.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
