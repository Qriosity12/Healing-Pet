import SwiftUI

struct MainTabView: View {
    @StateObject private var emotionRecordViewModel = EmotionRecordViewModel()  // 创建 EmotionRecordViewModel 实例

    var body: some View {
        TabView {
            PetView(emotionRecordViewModel: emotionRecordViewModel)  // 传递给 PetView
                .tabItem {
                    Label("陪伴", systemImage: "pawprint")
                }

            
            EmotionRecordView(vm: emotionRecordViewModel)  
                .tabItem {
                    Label("记录", systemImage: "chart.bar")
                }
            RelaxationView()  // 新增的放松与专注页面
                           .tabItem {
                               Label("放松与专注", systemImage: "waveform.path")
                           }
        }
    }
}
