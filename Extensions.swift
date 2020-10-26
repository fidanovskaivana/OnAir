//
//  Extensions.swift
//  4Music
//
//  Created by Ivana Fidanovska on 4/16/20.
//  Copyright © 2020 Fidanovska. All rights reserved.
//

import Foundation
import MediaPlayer


let LOADING_VIEW_KEY = "LoadingView"
var HEADER_HEIGHT: CGFloat = 0

extension MPVolumeView {
  static func setVolume(_ volume: Float) {
    let volumeView = MPVolumeView()
    let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider
    //volumeView.frame = CGRect(x: 100, y: 100, width: 50, height: 50)
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
      slider?.value = volume
    }
  }
}

