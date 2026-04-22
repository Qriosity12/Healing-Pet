import Foundation
import Combine

@MainActor
class PetViewModel: ObservableObject {

    @Published var petState: PetState = .idle
    @Published var replyText: String = "我在这里陪你"
    @Published var userInput: String = ""
    @Published var messages: [Message] = []

    func sendMessage() async -> AIResult? {
        let text = userInput.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return nil }

        userInput = ""
        messages.append(Message(content: text, isUserMessage: true))
        replyText = "宠物正在思考..."

        do {
            let result = try await DeepSeekService.shared.analyze(text: text)
            replyText = result.reply
            petState = mapEmotion(result.emotion)
            messages.append(Message(content: result.reply, isUserMessage: false))
            return result
        } catch {
            replyText = "我可能有点走神了，但我还在。"
            return nil
        }
    }

    private func mapEmotion(_ emotion: String) -> PetState {
        switch emotion {
        case "正向":
            return .happy
        case "疲惫", "焦虑", "负向", "孤独":
            return .comfort
        default:
            return .idle
        }
    }
}

struct Message: Identifiable {
    let id = UUID()
    let content: String
    let isUserMessage: Bool
}
