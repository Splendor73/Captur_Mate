import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TextRecognitionViewModel()

    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            // Image Section
            VStack(spacing: 16) {
                // Image Heading with Paste Icon Button
                HStack {
                    Text("Image")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.leading, 45)
                    Spacer()
                    
                    // Paste Button with Icon
                    Button(action: {
                        pasteImageFromClipboard()
                    }) {
                        Image(systemName: "doc.on.clipboard")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.blue)
                    }
                    .buttonStyle(.borderless)
                    .padding(.trailing, 10)
                    .help("Paste Image from Clipboard")
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
    
    private func pasteImageFromClipboard() {
        let pasteboard = NSPasteboard.general
        if let image = pasteboard.readObjects(forClasses: [NSImage.self], options: nil)?.first as? NSImage {
            // Clear any existing image data
            viewModel.selectedImageURL = nil
            viewModel.extractedText = ""

            // Save the NSImage as a temporary file
            let tempDirectory = FileManager.default.temporaryDirectory
            let tempFileURL = tempDirectory.appendingPathComponent("pasted_image.png")

            if let tiffData = image.tiffRepresentation,
               let bitmapImage = NSBitmapImageRep(data: tiffData),
               let pngData = bitmapImage.representation(using: .png, properties: [:]) {
                do {
                    try pngData.write(to: tempFileURL)
                    // Use the temporary file URL as if it were selected from the file system
                    viewModel.recognizeTextFromImage(at: tempFileURL)
                    
                    // Delete the temporary file after processing
                    DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
                        do {
                            try FileManager.default.removeItem(at: tempFileURL)
                            print("Temporary file deleted: \(tempFileURL)")
                        } catch {
                            print("Error deleting temporary file: \(error)")
                        }
                    }
                } catch {
                    print("Error saving pasted image: \(error)")
                }
            }
        }
    }

    private func copyTextToClipboard() {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(viewModel.extractedText, forType: .string)
    }
}
