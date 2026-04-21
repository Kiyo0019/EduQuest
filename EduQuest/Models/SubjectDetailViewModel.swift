//
//  SubjectDetailViewModel.swift
//  EduQuest
//
//  Created by Ahmad Sami on 4/16/26.
//

import Foundation
import Combine

final class SubjectDetailViewModel: ObservableObject {
    enum ContentKind: String {
        case lesson = "Lesson"
        case quiz = "Quiz"
        case challenge = "Challenge"

        var iconName: String {
            switch self {
            case .lesson:
                return "play.rectangle.fill"
            case .quiz:
                return "questionmark.circle.fill"
            case .challenge:
                return "flag.checkered"
            }
        }
    }

    struct ContentItem: Identifiable {
        let id = UUID()
        let kind: ContentKind
        let title: String
        let description: String
        let metadata: String?
        let badgeText: String?
    }

    @Published private(set) var subject: SubjectsViewModel.Subject
    @Published private(set) var items: [ContentItem]

    init(subject: SubjectsViewModel.Subject) {
        self.subject = subject
        self.items = SubjectDetailViewModel.makeItems(for: subject.id)
    }

    func handleTap(on item: ContentItem) {
        // Placeholder for future lesson, quiz, and challenge navigation.
        print("Open \(item.kind.rawValue): \(item.title)")
    }

    private static func makeItems(for subjectID: String) -> [ContentItem] {
        switch subjectID {
        case "programming":
            return [
                ContentItem(
                    kind: .lesson,
                    title: "Introduction to JavaScript",
                    description: "Get familiar with what JavaScript is and how it powers interactive apps.",
                    metadata: "12 min",
                    badgeText: "Video"
                ),
                ContentItem(
                    kind: .lesson,
                    title: "Variables and Basic Logic",
                    description: "Learn how to store values and make simple decisions with code.",
                    metadata: "14 min",
                    badgeText: "Lesson"
                ),
                ContentItem(
                    kind: .quiz,
                    title: "Basic JavaScript Concepts",
                    description: "5 questions on basic JavaScript concepts.",
                    metadata: "5 Questions",
                    badgeText: "Quiz"
                ),
                ContentItem(
                    kind: .lesson,
                    title: "Functions and Simple Input",
                    description: "Break code into reusable steps and work with simple user input.",
                    metadata: "16 min",
                    badgeText: "Lesson"
                ),
                ContentItem(
                    kind: .challenge,
                    title: "Calculator or Decision Tool",
                    description: "Build a simple calculator or mini decision tool using the concepts you learned.",
                    metadata: nil,
                    badgeText: "Challenge"
                )
            ]
        case "economics":
            return [
                ContentItem(
                    kind: .lesson,
                    title: "Needs vs Wants",
                    description: "Separate essentials from extras and see how choices shape spending habits.",
                    metadata: "10 min",
                    badgeText: "Lesson"
                ),
                ContentItem(
                    kind: .lesson,
                    title: "Supply and Demand Basics",
                    description: "Understand why prices rise or fall when supply or demand changes.",
                    metadata: "13 min",
                    badgeText: "Lesson"
                ),
                ContentItem(
                    kind: .quiz,
                    title: "Core Economics Ideas",
                    description: "5 questions on core economics ideas.",
                    metadata: "5 Questions",
                    badgeText: "Quiz"
                ),
                ContentItem(
                    kind: .lesson,
                    title: "Opportunity Cost in Daily Life",
                    description: "Apply tradeoff thinking to everyday choices and real decisions.",
                    metadata: "11 min",
                    badgeText: "Lesson"
                ),
                ContentItem(
                    kind: .challenge,
                    title: "Spending Choice Scenario",
                    description: "Analyze a real-life spending choice or market scenario and explain your reasoning.",
                    metadata: nil,
                    badgeText: "Challenge"
                )
            ]
        case "social-skills":
            return [
                ContentItem(
                    kind: .lesson,
                    title: "Starting Conversations",
                    description: "Practice openers and small talk strategies that feel natural and confident.",
                    metadata: "9 min",
                    badgeText: "Lesson"
                ),
                ContentItem(
                    kind: .lesson,
                    title: "Active Listening",
                    description: "Learn to show attention, ask better follow-up questions, and respond thoughtfully.",
                    metadata: "12 min",
                    badgeText: "Lesson"
                ),
                ContentItem(
                    kind: .quiz,
                    title: "Communication Basics",
                    description: "5 questions on communication basics.",
                    metadata: "5 Questions",
                    badgeText: "Quiz"
                ),
                ContentItem(
                    kind: .lesson,
                    title: "Reading Social Cues",
                    description: "Notice tone, timing, and body language to better understand interactions.",
                    metadata: "11 min",
                    badgeText: "Lesson"
                ),
                ContentItem(
                    kind: .challenge,
                    title: "Conversation Reflection Task",
                    description: "Complete a real-world conversation or reflection task and note what worked well.",
                    metadata: nil,
                    badgeText: "Challenge"
                )
            ]
        default:
            return [
                ContentItem(
                    kind: .lesson,
                    title: "Patterns and Number Sense",
                    description: "Spot number patterns and build confidence with flexible thinking.",
                    metadata: "10 min",
                    badgeText: "Lesson"
                ),
                ContentItem(
                    kind: .lesson,
                    title: "Basic Algebra Thinking",
                    description: "Understand simple relationships, unknowns, and balancing ideas.",
                    metadata: "14 min",
                    badgeText: "Lesson"
                ),
                ContentItem(
                    kind: .quiz,
                    title: "Simple Math Concepts",
                    description: "5 questions on simple math concepts.",
                    metadata: "5 Questions",
                    badgeText: "Quiz"
                ),
                ContentItem(
                    kind: .lesson,
                    title: "Solving Word Problems",
                    description: "Turn real situations into clear steps and solve them with structure.",
                    metadata: "15 min",
                    badgeText: "Lesson"
                ),
                ContentItem(
                    kind: .challenge,
                    title: "Real-World Problem Challenge",
                    description: "Solve and explain a short real-world problem using your math reasoning.",
                    metadata: nil,
                    badgeText: "Challenge"
                )
            ]
        }
    }
}
