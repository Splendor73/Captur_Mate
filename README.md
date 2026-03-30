# CapturMate

CapturMate is a powerful macOS application for **OCR (Optical Character Recognition)** with a global keyboard shortcut, menu bar integration, and smart layout-preserving text extraction.

## ✨ Features

### 🚀 Hybrid Workflow
- **Global Hotkey** (`⌃⇧S`) — Capture screen region from any app
- **Menu Bar Icon** — Quick access to capture, paste, and recent extractions
- **Main Window** — Full history, editing, and batch processing

### 🔤 Smart OCR
- **Layout-Preserving Text Extraction** — Maintains spacing, indentation, and column structure
- **Vision Framework** — Apple's built-in OCR with high accuracy
- **Confidence Indicator** — Visual feedback on extraction quality

### 📋 Productivity Features
- **Auto-Copy** — Text automatically copies to clipboard
- **Auto-Paste Mode** — Optionally pastes extracted text directly into active app
- **History** — Last 10 extractions with thumbnails and quick re-copy
- **Editable Text** — Edit before copying

---

## 📥 Download & Install

### Option 1: Download DMG (Recommended)

1. **Download:** [CapturMate.dmg](releases/CapturMate.dmg)
2. **Install:** 
   - Double-click the DMG
   - Drag CapturMate to `/Applications`
   - Eject the DMG
3. **Launch:** Open CapturMate from Applications
4. **Grant Permissions:**
   - **System Settings → Privacy & Security → Accessibility** → Add CapturMate ✅
   - **System Settings → Privacy & Security → Screen Recording** → Add CapturMate ✅
5. **Use:** Press `⌃⇧S` from any app!

### Option 2: Build from Source

```bash
git clone https://github.com/your-username/CapturMate.git
cd CapturMate/Captur_Mate
open CapturMate.xcodeproj
# Press ⌘R to build and run
```

---

## 🎯 Usage

| Action | How To |
|--------|--------|
| **Quick Capture** | Press `⌃⇧S` → select screen area → text auto-copies |
| **Paste & Extract** | Menu bar → Paste & Extract (for images already in clipboard) |
| **Auto-Paste** | Menu bar → toggle "Auto-Paste Mode" → extracted text auto-pastes |
| **View History** | Open main window → left sidebar shows last 10 extractions |
| **Edit Text** | Click in text area → edit → Copy Text button |

---

## 🛠 Technologies

- **Language:** Swift
- **Framework:** SwiftUI, Vision (OCR), SwiftData (history)
- **macOS:** 14.0+ (Sonoma or later)
- **Architecture:** Menu Bar Extra, Global Event Monitor

---

## 📸 Screenshots

> Coming soon

---

## 🤝 Contributing

Contributions welcome! Fork, create a feature branch, and open a pull request.

---

## 📄 License

MIT License — see `LICENSE` file for details.

---

## 👤 Author

**Yashu Patel**

- GitHub: [@Splendor73](https://github.com/Splendor73)
- LinkedIn: [Yashu Patel](https://www.linkedin.com/in/patel-yashu/)

---

## 🔑 Keywords

Swift OCR, macOS Vision framework, Apple Vision API, Text recognition Swift, Screenshot text extraction, CapturMate, Swift macOS app, Menu bar app, Global hotkey, Productivity tool
