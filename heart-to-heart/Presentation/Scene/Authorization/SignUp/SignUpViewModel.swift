import UIKit
import RxSwift

enum SignUpCoordinatorScreen {
    case signUp
    case logIn
    case findPassword
}

class SignUpViewModel: BaseViewModel {
    
    let email = BehaviorSubject<String>(value: "")
    let fullName = BehaviorSubject<String>(value: "")
    let nickname = BehaviorSubject<String>(value: "")
    let password = BehaviorSubject<String>(value: "")
    
    let isEmailValid = BehaviorSubject<Bool>(value: false)
    let isFullNameValid = BehaviorSubject<Bool>(value: false)
    let isNicknameValid = BehaviorSubject<Bool>(value: false)
    let isPasswordValid = BehaviorSubject<Bool>(value: false)
    
    let didClickSignUpButton = BehaviorSubject(value: false)
    let didClickLogInButton = BehaviorSubject(value: false)
    
    override init() {
        super.init()
        self.bindUI()
    }
    
    private func bindUI() {
        email.map(checkEmailValidation).bind(to: self.isEmailValid).disposed(by: self.disposeBag)
        fullName.map(checkFullNameValidation).bind(to: self.isFullNameValid).disposed(by: self.disposeBag)
        nickname.map(checkNicknameValidation).bind(to: self.isNicknameValid).disposed(by: self.disposeBag)
        password.map(checkPasswordValidation).bind(to: self.isPasswordValid).disposed(by: self.disposeBag)
    }
    
    private func checkEmailValidation(_ email: String?) -> Bool {
        guard email != nil else { return false }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func checkFullNameValidation(_ fullName: String?) -> Bool {
        guard fullName != nil else { return false }
        return fullName!.count > 8
    }
    
    private func checkNicknameValidation(_ nickName: String?) -> Bool {
        guard nickName != nil else { return false }
        return nickName!.count > 8
    }
    
    func checkPasswordValidation(_ password: String?) -> Bool {
        guard password != nil else { return false }
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordPred.evaluate(with: password)
    }
    
    func signUp() {
        didClickSignUpButton.onNext(true)
    }
    
    func logIn() {
        didClickLogInButton.onNext(true)
    }
}