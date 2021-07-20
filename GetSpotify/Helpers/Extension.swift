//
//  Extension.swift
//  GetSpotiAPI
//
//  Created by Дмитрий Рудаков on 16.07.2021.
//

import Foundation
import UIKit

extension UIWindow {
    static func getTopViewController() -> UIViewController? {
        var topController: UIViewController? = UIApplication.shared.windows.first?.rootViewController
        while topController?.presentedViewController != nil {
            topController = topController?.presentedViewController
        }
        return topController
    }
}
