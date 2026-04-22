import SwiftUI

struct EmotionRecordView: View {
    @ObservedObject var vm: EmotionRecordViewModel  // 接收传递的 EmotionRecordViewModel

    @State private var petImage = "pet_neutral"  // 默认宠物贴图

    var body: some View {
        VStack {
            HStack {
                // 标题
                Text("情绪记录")
                    .font(.largeTitle)
                    .padding()

                // 宠物贴图，微微向右倾斜
                Image(petImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)  // 设置宠物贴图的大小
                    .rotationEffect(.degrees(10))  // 微微倾斜
                    .padding(.leading, -20)  // 设置贴图与标题之间的间距
            }

            // 使用 List 显示所有情绪记录
            List(vm.records) { record in
                VStack(alignment: .leading) {
                    Text("情绪：\(record.emotion)")
                        .font(.subheadline)
                    Text(record.date, style: .date)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle("情绪记录")
        .padding()
    }
}
