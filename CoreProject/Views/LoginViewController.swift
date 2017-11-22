//
//  LoginViewController.swift
//  BaseMVC
//
//  Created by Henry Tran on 6/21/17.
//  Copyright © 2017 THL. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var infoLabel: UILabel!

    // MARK: - Varialbes

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.alpha = 0.6
        self.view.alpha = 0.6
        UIView.animate(withDuration: 0.3, delay: 0, options:[UIViewAnimationOptions.curveEaseIn], animations: {
            self.view.alpha = 1
            self.navigationController?.navigationBar.alpha = 1
        }, completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var paramsDict = Parameter()
        paramsDict["dict1"] = "dictv1"
        paramsDict["dict2"] = "dictv2"

        var params = Parameter()
        params["1"] = "2"
        params["bool1"] = true
        params["bool2"] = false
        params["int"] = 10
        params["dict"] = paramsDict
        params["array"] = [paramsDict]

        NetworkManager.upload(urlRequest: "hth", dataUpLoadInfo: nil, params: params, requestBack: { (request) in
            logD("request")
        }, progressHandler: { (current, total) in
            logD(current)
            logD(total)
        }) { (responseObject) in
            logD(responseObject)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showLoadingIndicator(inView: self.infoLabel, position: .center, offset: 0)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Setup View

    // MARK: - Call Api

    // MARK: - Actions
    @IBAction func touchButtonLoginAction(_ sender: Any) {
        self.hideLoadingIndicator()
        self.mainViewController?.setupMainTabbar()
        self.dismiss(animated: false) {}
    }

    // MARK: - Functions

}
