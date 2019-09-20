//
//  MockViewController.swift
//  bankAppTests
//
//  Created by Raphael Oliveira Chagas on 20/09/19.
//  Copyright © 2019 Raphael Oliveira Chagas. All rights reserved.
//

import UIKit

class MockViewController: UINavigationController {
    
    var pushedViewController: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        self.pushedViewController = viewController
    }
}
