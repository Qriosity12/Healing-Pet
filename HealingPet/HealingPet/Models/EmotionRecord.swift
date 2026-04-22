import Foundation

// 情绪记录模型
struct EmotionRecord: Identifiable {
    let id = UUID()       // 唯一标识符
    let emotion: String   // 情绪类型
    let date: Date        // 记录日期
}
