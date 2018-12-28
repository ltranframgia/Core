//
//  CertificateViewController.swift
//  CoreProject
//
//  Created by Huy Pham Quang on 12/27/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import UIKit

class CertificateViewController: BaseViewController {

    // MARK: - Variables
    fileprivate var request: NRequest?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func connectPressed(_ sender: Any) {
        // parameter
        var params = Parameter()
        params["id"] = "ltranframgia"
        params["password"] = "12345678"

        // create router
        let testCertificate = CertificateRouter.testCertificate(parameters: params)

        // request
        request?.cancel()
        request = NetworkManager.request(testCertificate) { [weak self] (responseObject) in
            logD(responseObject)

            guard let strongSelf = self else { return }

            // check
            if responseObject?.result == .success {

            } else if responseObject?.result == .error {

            } else if responseObject?.result == .cancelled {

            }
        }
    }
}
