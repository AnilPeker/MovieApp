//
//  BaseVC.swift
//  MovieApp
//
//  Created by Anıl Peker on 16.08.22.
//

import Foundation
import UIKit


class BaseVC: UIViewController {
    deinit {
        // To be sure that class will deinit
        
        print("--------------------------------------------------")
        print("----------\(self.classForCoder) Deinit----------------")
        print("--------------------------------------------------")
    }
}
