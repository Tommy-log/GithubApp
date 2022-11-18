//
//  BaseRouter.swift
//  RxSwiftMVVM
//
//  Created by User on 15.08.2022.
//

import Foundation
import UIKit

protocol BaseRouter: AnyObject {
    func initScene() -> UIViewController
}
