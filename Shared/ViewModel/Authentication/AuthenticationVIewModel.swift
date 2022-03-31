//
//  AuthenticationVIewModel.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 27-03-22.
//

import Foundation

final class AuthenticationViewModel: ObservableObject {
    
    @Published var user: UserModel?
    @Published var errorMessage: String?
    private let authenticationRepository: AuthenticationRepository
    
    init(authenticationRepository: AuthenticationRepository = AuthenticationRepository()) {
        self.authenticationRepository = authenticationRepository
        getCurrentUser()
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
    
    func recoverPass(email: String) {
        authenticationRepository.recoverPass(email: email) { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
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
}
