import SwiftUI
import AppKit

class TextRecognitionViewModel: ObservableObject {
    @Published var extractedText: String = ""
    @Published var selectedImageURL: URL?
    @Published var isProcessing: Bool = false

    // Function to select an image from the file system
    func selectImage() {
        let panel = NSOpenPanel()
        panel.allowedContentTypes = [.png, .jpeg]
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false

        if panel.runModal() == .OK, let url = panel.url {
            selectedImageURL = url
            recognizeTextFromImage(at: url)
        }
    }

    // Main function for text recognition
    func recognizeTextFromImage(at url: URL) {
        isProcessing = true
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let nsImage = NSImage(contentsOf: url) else {
                DispatchQueue.main.async {
                    self?.isProcessing = false
                    self?.extractedText = "Failed to load image"
                }
                return
            }
            
            let recognizedText = TextRecognitionService.recognizeText(from: nsImage) ?? "No text recognized"
            
            DispatchQueue.main.async {
                self?.isProcessing = false
                self?.extractedText = recognizedText
                print("UI Updated with text: \(recognizedText)")
            }
        }
    }

    // Function for copying the recognized text to clipboard
    func copyTextToClipboard() {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(extractedText, forType: .string)
    }
}
