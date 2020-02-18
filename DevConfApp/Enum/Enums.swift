//
//  Enums.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/12.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

// MARK: Error

enum CommonError: Error {
    case unknownError
    case networkingError
}
enum FirebaseDataStoreError: Error {
    case internalError
}

enum AuthError: Error {
    case emailIsInvalid
    case emailIsAlreadyUsed
    case passwordIsTooShort
}

// MARK: View Action

/*
 
  View Action系のenumはViewModelからViewControllerへ状態を伝え、Viewを変化させるための情報を表現する
 
*/

protocol ViewAction {}

enum CommonViewAction: ViewAction {
    case loading
    case newWorkError
    case unknownError
}


enum AuthViewAction: ViewAction {
    case showLoginError(String)
    case showSignUpError(String)
    case showEmailInvalidError(String)
    case showPasswordInvalidError(String)
    case ButtonStatusDidChange(Bool)
    case navigateToProfileSetting(String)
    case navigateToHome(String)
}

// MARK: Helper

enum ValidationStatus {
    case valid
    case invalid
}
