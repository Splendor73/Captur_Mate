import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TextRecognitionViewModel()

    var body: some View {
        HStack(alignment: .top) {
            VStack {
                if let imageURL = viewModel.selectedImageURL, let nsImage = NSImage(contentsOf: imageURL) {
                    ZStack(alignment: .topTrailing) {
                        Image(nsImage: nsImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                            .cornerRadius(10)
                            .shadow(radius: 10)

                        Button(action: {
                            viewModel.selectedImageURL = nil
                            viewModel.extractedText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                        .padding(8)
                    }
                } else {
                    Text("No image selected")
                        .foregroundColor(.gray)
                        .frame(width: 300, height: 300)
                        .background(Color.black.opacity(0.1))
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .padding()
                }
                

                Button(action: {
                    viewModel.selectImage()
                }) {
                    Text("Select Window")
                        .font(.headline)
                        .frame(width: 150, height: 50)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                                           startPoint: .leading, endPoint: .trailing)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(30)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                }
                .buttonStyle(.borderless)
                .padding(.top, 20)

            }
            .padding()

            VStack {
                ScrollView {
                    Text(viewModel.extractedText.isEmpty ? "No text extracted" : viewModel.extractedText)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .foregroundColor(.black)
                }
                .frame(width: 350, height: 300)
                .padding()

                Button(action: {
                    copyTextToClipboard()
                }) {
                    Text("Copy to Clipboard")
                        .font(.headline)
                        .frame(width: 150, height: 50)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.green, Color.teal]),
                                           startPoint: .leading, endPoint: .trailing)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(30)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                }
                .buttonStyle(.borderless)
                .padding(.top, 20)
            }
            .padding()
        }
        .padding()
        .background(Color.gray.opacity(0.1).ignoresSafeArea())
    }

    private func copyTextToClipboard() {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(viewModel.extractedText, forType: .string)
    }
}
