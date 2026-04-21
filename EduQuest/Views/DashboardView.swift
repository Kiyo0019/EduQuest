//
//  DashboardView.swift
//  EduQuest
//
//  Created by Ahmad Sami on 4/16/26.
//

import SwiftUI

struct DashboardView: View {
    @StateObject private var viewModel: DashboardViewModel

    private let statColumns = [
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14)
    ]

    init(viewModel: DashboardViewModel = DashboardViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            backgroundGradient
                .ignoresSafeArea()

            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 22) {
                    welcomeSection
                    statGrid
                    progressCard
                    streakCard
                    continueLearningSection
                }
                .padding(.horizontal, 20)
                .padding(.top, 28)
                .padding(.bottom, 32)
                .frame(maxWidth: 500, alignment: .leading)
                .frame(maxWidth: .infinity, alignment: .top)
            }
        }
    }

    private var welcomeSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Welcome back, \(viewModel.username)")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .foregroundStyle(Color.primary)
        }
    }

    private var statGrid: some View {
        LazyVGrid(columns: statColumns, spacing: 14) {
            ForEach(viewModel.statItems) { item in
                DashboardStatCard(item: item)
            }
        }
    }

    private var progressCard: some View {
        DashboardCard {
            VStack(alignment: .leading, spacing: 16) {
                Label("Your Progress", systemImage: "sparkles")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color.primary)

                ProgressView(value: viewModel.xpProgress)
                    .progressViewStyle(.linear)
                    .tint(Color.blue)
                    .scaleEffect(x: 1, y: 1.5, anchor: .center)

                Text(viewModel.levelProgressText)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundStyle(Color.secondary)
            }
        }
    }

    private var streakCard: some View {
        DashboardCard(
            fill: LinearGradient(
                colors: [
                    Color(red: 1.0, green: 0.96, blue: 0.89),
                    Color(red: 1.0, green: 0.90, blue: 0.76)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        ) {
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Daily Streak")
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color.primary)

                        Text("\(viewModel.streakDays) days in a row")
                            .font(.system(size: 26, weight: .bold, design: .rounded))
                            .foregroundStyle(Color.primary)
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    Spacer()

                    Image(systemName: "flame.fill")
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundStyle(Color.orange)
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text(viewModel.dailyGoalTitle)
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color.primary.opacity(0.9))

                    ProgressView(value: viewModel.dailyGoalProgress)
                        .progressViewStyle(.linear)
                        .tint(Color.orange)
                        .scaleEffect(x: 1, y: 1.4, anchor: .center)

                    Text(viewModel.dailyGoalProgressText)
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundStyle(Color.primary.opacity(0.75))
                }
            }
        }
    }

    @ViewBuilder
    private var continueLearningSection: some View {
        if let continueLesson = viewModel.continueLesson {
            DashboardCard {
                VStack(alignment: .leading, spacing: 16) {
                    Label("Continue Learning", systemImage: "play.circle.fill")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color.primary)

                    VStack(alignment: .leading, spacing: 8) {
                        Text(continueLesson.title)
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundStyle(Color.primary)

                        Text(continueLesson.description)
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundStyle(Color.secondary)
                            .fixedSize(horizontal: false, vertical: true)

                        Text(continueLesson.progressText)
                            .font(.system(size: 13, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color.blue)
                    }

                    Button(action: viewModel.continueLearning) {
                        HStack {
                            Text("Continue")
                                .font(.system(size: 17, weight: .semibold, design: .rounded))

                            Spacer()

                            Image(systemName: "arrow.right")
                                .font(.system(size: 15, weight: .bold))
                        }
                        .foregroundStyle(Color.white)
                        .padding(.horizontal, 18)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(
                                colors: [Color.blue, Color.teal],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    }
                    .buttonStyle(.plain)
                }
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

private struct DashboardStatCard: View {
    let item: DashboardViewModel.StatItem

    var body: some View {
        DashboardCard {
            VStack(alignment: .leading, spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(accentColor.opacity(0.12))
                        .frame(width: 44, height: 44)

                    Image(systemName: item.iconName)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(accentColor)
                }

                Text(item.title)
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color.secondary)

                Text("\(item.value)")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.primary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private var accentColor: Color {
        Color(hex: item.accentColorHex)
    }
}

private struct DashboardCard<Content: View>: View {
    let fill: AnyShapeStyle
    @ViewBuilder let content: Content

    init(
        fill: some ShapeStyle = Color.white.opacity(0.94),
        @ViewBuilder content: () -> Content
    ) {
        self.fill = AnyShapeStyle(fill)
        self.content = content()
    }

    var body: some View {
        content
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(fill)
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
    DashboardView()
}
