//
//  CreateAccountView.swift
//  EduQuest
//
//  Created by Ahmad Sami on 4/16/26.
//

import SwiftUI

struct CreateAccountView: View {
    @State private var viewModel: CreateAccountViewModel
    @FocusState private var focusedField: Field?

    private enum Field {
        case username
        case email
        case password
    }

    init(viewModel: CreateAccountViewModel = CreateAccountViewModel()) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                VStack {
                    Spacer(minLength: max(geometry.size.height * 0.08, 36))

                    VStack(spacing: 28) {
                        headerSection
                        formSection
                        statusSection
                        signUpButton
                    }
                    .frame(maxWidth: 420)
                    .padding(.horizontal, 24)

                    Spacer(minLength: max(geometry.size.height * 0.12, 48))
                }
                .frame(minHeight: geometry.size.height)
            }
            .scrollDismissesKeyboard(.interactively)
            .background {
                backgroundGradient
                    .ignoresSafeArea()
            }
        }
    }

    private var headerSection: some View {
        VStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color.blue.opacity(0.14), Color.teal.opacity(0.10)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 88, height: 88)

                Image(systemName: "graduationcap.fill")
                    .font(.system(size: 32, weight: .semibold))
                    .foregroundStyle(Color.blue)
            }

            Text("Create an Account")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundStyle(Color.primary)

        }
    }

    private var formSection: some View {
        VStack(spacing: 18) {
            labeledField(
                title: "Username",
                prompt: "Choose a username",
                text: $viewModel.username,
                field: .username,
                textContentType: .username,
                keyboardType: .default,
                isSecure: false
            )

            labeledField(
                title: "Email",
                prompt: "Enter your email",
                text: $viewModel.email,
                field: .email,
                textContentType: .emailAddress,
                keyboardType: .emailAddress,
                isSecure: false
            )

            labeledField(
                title: "Password",
                prompt: "Create a password",
                text: $viewModel.password,
                field: .password,
                textContentType: .newPassword,
                keyboardType: .default,
                isSecure: true
            )
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(Color.white.opacity(0.92))
                .shadow(color: Color.black.opacity(0.05), radius: 18, x: 0, y: 10)
        )
    }

    @ViewBuilder
    private var statusSection: some View {
        if let errorMessage = viewModel.errorMessage {
            messageCard(text: errorMessage, tint: Color.red, icon: "exclamationmark.circle.fill")
        } else if viewModel.isSignUpComplete {
            messageCard(
                text: "Account created locally. The app can now route to the next screen.",
                tint: Color.green,
                icon: "checkmark.circle.fill"
            )
        }
    }

    private var signUpButton: some View {
        Button(action: submitSignUp) {
            Text("Sign Up")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .background(
                    LinearGradient(
                        colors: [Color.blue, Color.teal],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: Color.blue.opacity(0.22), radius: 14, x: 0, y: 8)
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 4)
    }

    private var backgroundGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color(red: 0.98, green: 0.99, blue: 1.0),
                Color(red: 0.94, green: 0.98, blue: 1.0)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }

    @ViewBuilder
    private func labeledField(
        title: String,
        prompt: String,
        text: Binding<String>,
        field: Field,
        textContentType: UITextContentType?,
        keyboardType: UIKeyboardType,
        isSecure: Bool
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundStyle(Color.primary)

            Group {
                if isSecure {
                    SecureField(prompt, text: text)
                        .textContentType(textContentType)
                } else {
                    TextField(prompt, text: text)
                        .textContentType(textContentType)
                        .keyboardType(keyboardType)
                        .textInputAutocapitalization(field == .email ? .never : .words)
                }
            }
            .focused($focusedField, equals: field)
            .submitLabel(field == .password ? .go : .next)
            .onSubmit {
                moveFocus(from: field)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(Color.white)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(borderColor(for: field), lineWidth: 1.2)
            )
        }
    }

    private func messageCard(text: String, tint: Color, icon: String) -> some View {
        HStack(alignment: .center, spacing: 10) {
            Image(systemName: icon)
                .foregroundStyle(tint)

            Text(text)
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundStyle(Color.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(14)
        .background(tint.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }

    private func borderColor(for field: Field) -> Color {
        focusedField == field ? Color.blue.opacity(0.8) : Color.black.opacity(0.08)
    }

    private func moveFocus(from field: Field) {
        switch field {
        case .username:
            focusedField = .email
        case .email:
            focusedField = .password
        case .password:
            submitSignUp()
        }
    }

    private func submitSignUp() {
        focusedField = nil
        viewModel.signUp()
    }
}

#Preview {
    CreateAccountView()
}
//i added second line code
