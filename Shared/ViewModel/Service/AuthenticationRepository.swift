//
//  AuthenticationRepository.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 27-03-22.
//

import Foundation


final class AuthenticationRepository {
    private let authenticationFirebaseDatasource: AuthenticationFirebaseDatasource
    
    init(authenticationFirebaseDataSource: AuthenticationFirebaseDatasource = AuthenticationFirebaseDatasource()) {
        self.authenticationFirebaseDatasource = authenticationFirebaseDataSource
    }
    
    func getCurrentUser() -> UserModel? {
        authenticationFirebaseDatasource.getCurrentUser()
    }
    
    func createNewUser(email: String, password: String, completionBlock: @escaping (Result<UserModel, Error>) -> Void) {
        authenticationFirebaseDatasource.createNewUser(email: email, password: password, completionBlock: completionBlock)
    }
    
    func signin(email: String, password: String, completionBlock: @escaping (Result<UserModel, Error>) -> Void) {
        authenticationFirebaseDatasource.signin(email: email, password: password, completionBlock: completionBlock)
    }
    
    func recoverPass(email: String, completionBlock: @escaping (Result<UserModel, Error>) -> Void) {
        authenticationFirebaseDatasource.recoverPass(email: email, completionBlock: completionBlock)
    }
    
    func logout() throws {
        try authenticationFirebaseDatasource.logout()
    }
}
