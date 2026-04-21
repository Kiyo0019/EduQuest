//
//  CreateAccountViewModel.swift
//  EduQuest
//
//  Created by Ahmad Sami on 4/16/26.
//

import Foundation
import Observation

@Observable
final class CreateAccountViewModel {
    var username = ""
    var email = ""
    var password = ""
    var errorMessage: String?
    private(set) var isRegistered = false

    var isSignUpComplete: Bool {
        isRegistered
    }

    func signUp() {
        let trimmedUsername = username.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedUsername.isEmpty else {
            errorMessage = "Please enter a username."
            isRegistered = false
            return
        }

        guard !trimmedEmail.isEmpty else {
            errorMessage = "Please enter your email address."
            isRegistered = false
            return
        }

        guard trimmedEmail.contains("@"), trimmedEmail.contains(".") else {
            errorMessage = "Enter a valid email address."
            isRegistered = false
            return
        }

        guard !password.isEmpty else {
            errorMessage = "Please enter a password."
            isRegistered = false
            return
        }

        guard password.count >= 8 else {
            errorMessage = "Your password must be at least 8 characters."
            isRegistered = false
            return
        }

        // Placeholder for future backend account creation.
        username = trimmedUsername
        email = trimmedEmail
        errorMessage = nil
        isRegistered = true
    }
}
