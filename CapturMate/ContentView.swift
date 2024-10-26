import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TextRecognitionViewModel()

    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            // Image Section
            VStack(spacing: 16) {
                // Image Heading
                HStack {
                    Text("Image")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.leading, 45)
                    Spacer()
                }

                // Image Display
                if let imageURL = viewModel.selectedImageURL, let nsImage = NSImage(contentsOf: imageURL) {
                    ZStack(alignment: .topTrailing) {
                        Image(nsImage: nsImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 320, height: 300)
                            .cornerRadius(12)
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
                        .frame(width: 320, height: 300)
                        .background(Color.black.opacity(0.1))
                        .cornerRadius(12)
                        .shadow(radius: 10)
                        .padding(.horizontal, 20)
                }

                // Action Buttons
                HStack(spacing: 20) {
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
                            .cornerRadius(25)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                    }
                    .buttonStyle(.borderless)

                    Button(action: {
                        copyTextToClipboard()
                    }) {
                        Text("Copy Text")
                            .font(.headline)
                            .frame(width: 150, height: 50)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color.green, Color.teal]),
                                               startPoint: .leading, endPoint: .trailing)
                            )
                            .foregroundColor(.white)
                            .cornerRadius(25)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                    }
                    .buttonStyle(.borderless)
                }
                .padding(.top, 10)
            }
            .padding()
            .frame(minWidth: 400)

            Divider()
                .background(Color.gray.opacity(0.3))

            // Text Section
            VStack(spacing: 16) {
                // Text Heading
                HStack {
                    Text("Extracted Text")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.leading, 20)
                    Spacer()
                }

                // Text Display
                ScrollView {
                    Text(viewModel.extractedText.isEmpty ? "No text extracted" : viewModel.extractedText)
                        .font(.system(.body, design: .monospaced))
                        .foregroundColor(Color.primary)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)
                        .padding(10)
                }
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                .shadow(radius: 8)
            }
            .padding()
            .frame(minWidth: 400)
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
