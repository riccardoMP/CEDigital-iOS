//
//  Box.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 10/19/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//https://www.raywenderlich.com/6733535-ios-mvvm-tutorial-refactoring-from-mvc

import Foundation

final class Box<T> {
  //1
  typealias Listener = (T) -> Void
  var listener: Listener?
  //2
  var value: T {
    didSet {
      listener?(value)
    }
  }
  //3
  init(_ value: T) {
    self.value = value
  }
  //4
  func bind(listener: Listener?) {
    self.listener = listener
    listener?(value)
  }
}
