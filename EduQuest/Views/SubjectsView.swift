//
//  SubjectsView.swift
//  EduQuest
//
//  Created by Ahmad Sami on 4/16/26.
//

import SwiftUI

struct SubjectsView: View {
    @StateObject private var viewModel: SubjectsViewModel

    init(viewModel: SubjectsViewModel = SubjectsViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                backgroundGradient
                    .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 22) {
                        headerSection
                        subjectsList
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 28)
                    .padding(.bottom, 32)
                    .frame(maxWidth: 500, alignment: .leading)
                    .frame(maxWidth: .infinity, alignment: .top)
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(for: SubjectsViewModel.Subject.self) { subject in
                SubjectDetailView(viewModel: viewModel.makeDetailViewModel(for: subject))
            }
        }
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(viewModel.title)
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundStyle(Color.primary)

            Text(viewModel.subtitle)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundStyle(Color.secondary)
        }
    }

    private var subjectsList: some View {
        VStack(spacing: 16) {
            ForEach(viewModel.subjects) { subject in
                NavigationLink(value: subject) {
                    SubjectCard(subject: subject)
                }
                .buttonStyle(.plain)
            }
        }
    }

    private var backgroundGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color(red: 0.99, green: 1.0, blue: 1.0),
                Color(red: 0.95, green: 0.98, blue: 1.0)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

private struct SubjectCard: View {
    let subject: SubjectsViewModel.Subject

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(accentColor.opacity(0.12))
                    .frame(width: 58, height: 58)

                Image(systemName: subject.iconName)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(accentColor)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(subject.title)
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.primary)

                Text(subject.description)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundStyle(Color.secondary)
                    .fixedSize(horizontal: false, vertical: true)

                Text(subject.summary)
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundStyle(accentColor)
            }

            Spacer(minLength: 0)

            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(Color.secondary.opacity(0.7))
                .padding(.top, 6)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .fill(Color.white.opacity(0.95))
                .shadow(color: Color.black.opacity(0.05), radius: 18, x: 0, y: 10)
        )
    }

    private var accentColor: Color {
        Color(hex: subject.accentColorHex)
    }
}

private extension Color {
    init(hex: String) {
        let sanitizedHex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var value: UInt64 = 0
        Scanner(string: sanitizedHex).scanHexInt64(&value)

        let red = Double((value >> 16) & 0xFF) / 255
        let green = Double((value >> 8) & 0xFF) / 255
        let blue = Double(value & 0xFF) / 255

        self.init(red: red, green: green, blue: blue)
    }
}

#Preview {
    SubjectsView()
}
