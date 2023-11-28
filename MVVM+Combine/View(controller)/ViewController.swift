//
//  ViewController.swift
//  MVVM+Combine
//
//  Created by 오예준 on 2023/11/27.
//

import UIKit
import Combine
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
    
    private var viewModel:LoginViewModel = LoginViewModel()
    private var cancellables = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
    }
    
    func setup() {
        btnSignup.isEnabled = false
    }
    
    func bind() {
        let input = LoginViewModel.Input(id: idTextField.textPublisher, pwd: pwdTextField.textPublisher, confirm: confirmTextField.textPublisher)
        let ouput = viewModel.transform(input)
        ouput.btnState
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { state in
                self.btnSignup.isEnabled = state
            })
            .store(in: &cancellables)
    }

    @IBAction func pressedBtnSignup(_ sender: Any) {
        
    }
    
}

