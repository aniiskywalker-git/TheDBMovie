//
//  LoginViewModel.swift
//  TheMovieDB
//
//  Created by Ana Victoria Frias.
//

import Foundation

protocol LoginViewModelInput {
    func viewDidLoad()
    func authenticate(email: String, password: String)
}

protocol LoginViewModelOutput {
    var error: Observable<String> { get }
    var screenTitle: String { get }
    var errorTitle: String { get }
}

typealias LoginViewModel = LoginViewModelInput & LoginViewModelOutput

final class DefaultLoginViewModel: LoginViewModel {
    
    private var loginLoadTask: Cancellable? { willSet { loginLoadTask?.cancel() } }
    private let loginUseCase: LoginUseCase
    private let mainQueue: DispatchQueueType
    
    let error: Observable<String> = Observable("")
    let screenTitle = NSLocalizedString("Login", comment: "")
    let errorTitle = NSLocalizedString("Error", comment: "")
    
    func viewDidLoad() {}
    
    init(loginUseCase: LoginUseCase, mainQueue: DispatchQueueType = DispatchQueue.main) {
        self.loginUseCase = loginUseCase
        self.mainQueue = mainQueue
    }
    
    func authenticate(email: String, password: String) {
        guard validateEmail(emailAddressString: email) else { return }
        
        loginLoadTask = loginUseCase.execute(requestValue: .init(email: email, password: password), completion: { [weak self] result in
            self?.mainQueue.async {
                switch result {
                case .success(let success):
                    print(success, "success")
                    self?.goToTVShowsList()
                case .failure(let error):
                    self?.handle(error: error)
                }
            }
        })
    }
    
    func goToTVShowsList() {
        
    }
    
    private func handle(error: Error) {
        self.error.value = error.isInternetConnectionError ?
        NSLocalizedString("No internet connection", comment: "") :
        NSLocalizedString("Failed loading movies", comment: "")
    }
    
    func validateEmail(emailAddressString: String) -> Bool {
        var returnValue = true
            let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
            
            do {
                let regex = try NSRegularExpression(pattern: emailRegEx)
                let nsString = emailAddressString as NSString
                let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
                
                if results.count == 0
                {
                    returnValue = false
                }
                
            } catch let error {
                print("invalid regex: \(error.localizedDescription)")
                returnValue = false
            }
            
            return returnValue
    }
    
}
