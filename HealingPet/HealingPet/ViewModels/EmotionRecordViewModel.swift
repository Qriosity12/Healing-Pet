import Foundation
import Combine
import SwiftUI

class EmotionRecordViewModel: ObservableObject {
    @Published var records: [EmotionRecord] = []

    // 初始化时直接添加一些预设的情绪记录
    init() {
        // 这里初始化一些写死的记录
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        if let date1 = formatter.date(from: "2023/12/01") {
            records.append(EmotionRecord(emotion: "开心", date: date1))
        }
        if let date2 = formatter.date(from: "2023/12/05") {
            records.append(EmotionRecord(emotion: "疲惫", date: date2))
        }
        if let date3 = formatter.date(from: "2023/12/10") {
            records.append(EmotionRecord(emotion: "焦虑", date: date3))
        }
    }
    // 添加情绪记录的方法
       func add(emotion: String, date: Date) {
           let record = EmotionRecord(emotion: emotion, date: date)
           records.append(record)  // 将情绪记录添加到数组中
           print("情绪记录已添加：", record)
       }

    // 根据日期获取记录
    func records(for date: Date) -> [EmotionRecord] {
        let calendar = Calendar.current
        return records.filter { calendar.isDate($0.date, inSameDayAs: date) }
    }
}
