//
//  SubjectDetailView.swift
//  EduQuest
//
//  Created by Ahmad Sami on 4/16/26.
//

import SwiftUI

struct SubjectDetailView: View {
    @StateObject private var viewModel: SubjectDetailViewModel
    @Environment(\.dismiss) private var dismiss

    init(viewModel: SubjectDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            backgroundGradient
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 22) {
                    heroCard
                    contentSection
                }
                .padding(.horizontal, 20)
                .padding(.top, 18)
                .padding(.bottom, 28)
                .frame(maxWidth: 500, alignment: .leading)
                .frame(maxWidth: .infinity, alignment: .top)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: { dismiss() }) {
                    HStack(spacing: 6) {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color.primary)
                }
            }
        }
    }

    private var heroCard: some View {
        VStack(alignment: .leading, spacing: 18) {
            ZStack {
                Circle()
                    .fill(accentColor.opacity(0.14))
                    .frame(width: 72, height: 72)

                Image(systemName: viewModel.subject.iconName)
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundStyle(accentColor)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.subject.title)
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.primary)

                Text(viewModel.subject.description)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundStyle(Color.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(Color.white.opacity(0.95))
                .shadow(color: Color.black.opacity(0.05), radius: 18, x: 0, y: 10)
        )
    }

    private var contentSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Content")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundStyle(Color.primary)

            ForEach(viewModel.items) { item in
                Button(action: { viewModel.handleTap(on: item) }) {
                    SubjectContentCard(item: item, accentColor: accentColor)
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

    private var accentColor: Color {
        Color(hex: viewModel.subject.accentColorHex)
    }
}

private struct SubjectContentCard: View {
    let item: SubjectDetailViewModel.ContentItem
    let accentColor: Color

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(accentColor.opacity(0.12))
                    .frame(width: 48, height: 48)

                Image(systemName: item.kind.iconName)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(accentColor)
            }

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(item.kind.rawValue)
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundStyle(accentColor)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(accentColor.opacity(0.10))
                        .clipShape(Capsule())

                    if let badgeText = item.badgeText {
                        Text(badgeText)
                            .font(.system(size: 12, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color.secondary)
                    }
                }

                Text(item.title)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.primary)

                Text(item.description)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundStyle(Color.secondary)
                    .fixedSize(horizontal: false, vertical: true)

                if let metadata = item.metadata {
                    Text(metadata)
                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color.primary.opacity(0.7))
                }
            }

            Spacer(minLength: 0)

            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(Color.secondary.opacity(0.7))
                .padding(.top, 4)
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color.white.opacity(0.95))
                .shadow(color: Color.black.opacity(0.05), radius: 18, x: 0, y: 10)
        )
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
    NavigationStack {
        SubjectDetailView(
            viewModel: SubjectDetailViewModel(
                subject: SubjectsViewModel.Subject(
                    id: "programming",
                    title: "Programming",
                    iconName: "laptopcomputer",
                    description: "Learn to code and build real projects",
                    summary: "3 lessons, 1 quiz, 1 challenge",
                    accentColorHex: "#3B82F6"
                )
            )
        )
    }
}
