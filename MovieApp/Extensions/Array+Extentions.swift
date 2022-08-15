//
//  Array+Extentions.swift
//  MovieApp
//
//  Created by Anıl Peker on 15.08.22.
//

import Foundation

extension Array{
    mutating func appends(_ items : [Element]){
        for s in items{
            self.append(s)
        }
    }
}
