import Foundation

struct AIResult: Codable {
    let emotion: String
    let reply: String
}

enum DeepSeekConfiguration {
    static var apiKey: String {
        ProcessInfo.processInfo.environment["DEEPSEEK_API_KEY"] ?? ""
    }
}

class DeepSeekService {

    static let shared = DeepSeekService()

    func analyze(text: String) async throws -> AIResult {
        let apiKey = DeepSeekConfiguration.apiKey.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !apiKey.isEmpty else {
            throw URLError(.userAuthenticationRequired)
        }

        let url = URL(string: "https://api.deepseek.com/chat/completions")!

        let prompt = """
        你是一个治愈型桌面电子宠物。如果用户情绪强烈，
        请判断用户情绪，并安慰。安慰语不得为空。
        返回 JSON：
        {
          "emotion": "正向/疲惫/焦虑/负向/孤独/平淡",
          "reply": "安慰语"
        }
        用户说：\(text)
        """

        let body: [String: Any] = [
            "model": "deepseek-chat",
            "messages": [
                ["role": "user", "content": prompt]
            ]
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, _) = try await URLSession.shared.data(for: request)

        let json = try JSONSerialization.jsonObject(with: data) as! [String: Any]
        let content = (((json["choices"] as! [[String: Any]]).first!["message"] as! [String: Any])["content"] as! String)

        let resultData = content.data(using: .utf8)!
        return try JSONDecoder().decode(AIResult.self, from: resultData)
    }
}
