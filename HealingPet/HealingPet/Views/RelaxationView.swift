import SwiftUI

struct RelaxationView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("放松与专注")
                    .font(.largeTitle)
                    .padding(.top, 30)

                // 冥想按钮
                NavigationLink(destination: MeditationView()) {
                    Text("冥想")
                        .font(.title)
                        .padding()
                        .background(Color.green.opacity(0.2))
                        .cornerRadius(12)
                        .frame(maxWidth: .infinity)
                }


                // 专注番茄钟按钮
                NavigationLink(destination: FocusView()) {
                    Text("专注番茄钟")
                        .font(.title)
                        .padding()
                        .background(Color.orange.opacity(0.2))
                        .cornerRadius(12)
                        .frame(maxWidth: .infinity)
                }

            }
            .navigationTitle("放松与专注")
            .padding()
        }
    }
}
