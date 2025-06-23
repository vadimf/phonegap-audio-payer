# iOS Native Audio Player Plugin for PhoneGap 3.0

This plugin was developed by **Globalbit**, an Israeli software company specializing in complex digital systems and cross-platform mobile solutions.  
It provides a native audio playback solution for PhoneGap 3.0, enabling seamless background music playback with lock screen metadata support — overcoming the limitations of HTML5 audio on iOS.

---

## 🎯 Why This Plugin?

While building a mobile radio app using PhoneGap, we encountered three key limitations:

- ❌ HTML5 audio stops reliably working in background mode
- ❌ iOS system suspends the app if playback is interrupted
- ❌ CDVSound (default audio plugin) introduced unacceptable latency

### ✅ This plugin enables:

- 🔊 Continuous **playlist playback** in background mode
- 🔒 **Lock screen metadata** (song title, artist, etc.)
- ⚡ Minimal latency for smooth playback transitions

---

## ⚙️ Installation

1. **Add iOS Frameworks** to your Xcode project:
   - `AVFoundation.framework`
   - `CoreAudio.framework`
   - `MediaPlayer.framework`
   - `AudioToolbox.framework`

2. **Update `Info.plist`:**
```xml
<key>UIBackgroundModes</key>
<array>
  <string>audio</string>
</array>
Include plugin files in your project:
AudioPlayerPlugin.m
AudioPlayerPlugin.h
GBAudioPlayer.m
GBAudioPlayer.h
Add JS bridge:
Place AudioPlayerPlugin.js inside /www/js/
Update config.xml:
<feature name="AudioPlayerPlugin">
  <param name="ios-package" value="AudioPlayerPlugin" />
</feature>
🚀 Usage

See the index.html file in the repository for a working code example.
Initialize the plugin, load your playlist, and enjoy reliable background audio playback on iOS devices.

🧩 About Globalbit

Globalbit is a leading Israeli software development company that delivers robust, scalable web mobile and AI solutions to enterprises, governments, and startups.
We’ve built platforms used by over 200 million users across industries like finance, mobility, healthcare, and media.

🔍 What We Do:
Native & hybrid mobile app development (iOS, Android, Flutter, React Native)
Web platforms, digital portals, enterprise integrations
Agentic AI, cloud infrastructure, DevOps, QA
📞 Let’s Build Digital Together

This plugin is one example of Globalbit’s focus on low-level performance, native integration, and real-world functionality in mobile environments.

📩 Contact: info@globalbit.co.il
🌐 Website: globalbit.co.il
