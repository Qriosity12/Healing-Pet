import SwiftUI

struct PetView: View {
    @ObservedObject var emotionRecordViewModel: EmotionRecordViewModel
    @StateObject var vm = PetViewModel()
    @FocusState private var isInputFocused: Bool
    @State private var petImage: String = "pet_happy"
    @State private var welcomeMessage: String = "你好呀，我是你的治愈型宠物！快来和我聊天吧！🥳"

    let petImages = ["pet_happy", "pet_neutral"]

    var body: some View {
        VStack {
            Image(petImage)
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
                .padding()

            ScrollViewReader { scrollView in
                ScrollView {
                    VStack(spacing: 10) {
                        HStack {
                            Text(welcomeMessage)
                                .padding(10)
                                .background(Color.green.opacity(0.2))
                                .cornerRadius(12)
                                .padding(.trailing, 50)
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                        .id("welcomeMessage")

                        ForEach(vm.messages) { message in
                            HStack {
                                if message.isUserMessage {
                                    Spacer()
                                    Text(message.content)
                                        .padding(10)
                                        .background(Color.yellow.opacity(0.2))
                                        .cornerRadius(12)
                                        .padding(.leading, 10)
                                        .padding(.trailing, 50)
                                } else {
                                    Text(message.content)
                                        .padding(10)
                                        .background(Color.green.opacity(0.2))
                                        .cornerRadius(12)
                                        .padding(.trailing, 10)
                                        .multilineTextAlignment(.center)
                                    Spacer()
                                }
                            }
                            .id(message.id)
                        }
                    }
                }
                .onChange(of: vm.messages.count) {
                    withAnimation {
                        scrollView.scrollTo(vm.messages.last?.id, anchor: .bottom)
                    }
                }
            }

            if vm.replyText == "宠物正在思考..." {
                Text(vm.replyText)
                    .italic()
                    .foregroundColor(.gray)
                    .padding()
            }

            TextField("和我说点什么吧", text: $vm.userInput)
                .focused($isInputFocused)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            Button("发送") {
                Task {
                    if let aiResult = await vm.sendMessage() {
                        emotionRecordViewModel.add(emotion: aiResult.emotion, date: Date())

                        switch aiResult.emotion {
                        case "正向":
                            petImage = "pet_happy"
                        default:
                            petImage = "pet_neutral"
                        }
                    }

                    isInputFocused = false
                }
            }
            .buttonStyle(.borderedProminent)
            .padding(.top, 10)
        }
        .padding()
        .onTapGesture {
            isInputFocused = false
        }
        .onAppear {
            petImage = petImages.randomElement() ?? "pet_happy"
        }
    }
}
