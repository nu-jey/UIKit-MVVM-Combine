//
//  ViewController.swift
//  MVVM+Combine
//
//  Created by 오예준 on 2023/11/27.
//

import UIKit

class ViewController: UIViewController {
    // 요구사항
    // 1. id는 5자리 이상
    // 2. pwd는 7자리 이상
    // 3. pwd와 confirm은 동일
    // 4. 1,2,3이 모두 충족되어야 sign up 활성화
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    
    @IBOutlet weak var btnSignup: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSignup.isEnabled = false
    }

    @IBAction func pressedBtnSignup(_ sender: Any) {
        
    }
    
}

