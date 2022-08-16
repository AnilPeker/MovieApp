//
//  GlobalHelpers.swift
//  MovieApp
//
//  Created by Anıl Peker on 14.08.22.
//

import Foundation

// To increase developement speed this functions are usable.
func onMain(completion: @escaping () -> Void) -> Void {
    DispatchQueue.main.async {
        completion()
    }
}

func dispatchAfter(_ time: Double, completion: @escaping () -> Void) -> Void {
    DispatchQueue.main.asyncAfter(deadline: .now() + time) {
        completion()
    }
}
