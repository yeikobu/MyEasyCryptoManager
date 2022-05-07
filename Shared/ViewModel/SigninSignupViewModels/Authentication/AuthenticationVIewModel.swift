//
//  AuthenticationVIewModel.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 27-03-22.
//

import Foundation

final class AuthenticationViewModel: ObservableObject {
    
    @Published var user: UserModel?
    @Published var errorMessage: String = ""
    @Published var successMessage: String = ""
    private let authenticationRepository: AuthenticationRepository
    
    init(authenticationRepository: AuthenticationRepository = AuthenticationRepository()) {
        self.authenticationRepository = authenticationRepository
        getCurrentUser()
        print(user?.email ?? "")
    }
    
    func getCurrentUser() {
        self.user = authenticationRepository.getCurrentUser()
    }
    
    func createNewUser(email: String, password: String) {
        authenticationRepository.createNewUser(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
        }
    }
    
    func signin(email: String, password: String, completionBLock: @escaping(String) -> Void) {
        authenticationRepository.signin(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
                completionBLock(error.localizedDescription)
            }
        }
    }
    
    func recoverPass(completionBlock: @escaping(String) -> Void) {
        authenticationRepository.recoverPass() { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
                completionBlock("An email has been sent to your current email")
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
                completionBlock(error.localizedDescription)
            }
        }
    }
    
    func logout() {
        do {
            try authenticationRepository.logout()
            self.user = nil
        } catch {
            print(error)
        }
    }
    
    func checkIfUserExist(email: String, password: String, completionBlock: @escaping(Bool) -> Void)  {
        authenticationRepository.checkIsUserExist(email: email, password: password) { isUserExist in
            if isUserExist {
                completionBlock(isUserExist)
            } else {
                completionBlock(isUserExist)
            }
        }
    }
    
    func changeEmail(email: String, completionBlock: @escaping(Bool) -> Void) {
        var isEmailChanged: Bool = false
        authenticationRepository.changeEmail(email: email) { result in
            switch result {
            case .success( _):
                self.successMessage = "Email has been updated"
                isEmailChanged = true
                completionBlock(isEmailChanged)
                
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                print(error.localizedDescription)
                isEmailChanged = false
                completionBlock(isEmailChanged)
            }
        }
    }
}
