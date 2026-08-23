# Vellio
A privacy-first, offline-tracking expense tracking application built with flutter. This project is designed to help users monitor their daily spending without relying on expensive third-party banking APIs or compromising their financial data privacy
## Features
- **Custom SMS Auto-Categorization:** Features a custom-built regex parsing engine. It intercepts incoming bank alert SMS messages, extracts the transaction amount, date, and type (Credit/Debit), and logs the expense automatically.
- **Nigerian Bank Support:** Specifically tailored to parse alert formats from major Nigerian financial institutions.
- **Manual Logging Engine:** A streamlined, friction-free manual entry for tracking unrecorded physical cash transactions.
- **100% Local Processing:** All data parsing and storage happens directly on the device. No financial details ever sent to a remote backend or cloud server.
## Tech Stack
- **Framework:** Flutter / Dart
- **Local Storage:** Shared Preferences
- **Device APIs:** `telephony` (for Android SMS interception and background execution)
- **Core Logic:** Custom Regular Expression (Regex) string manipulation.
## Parsing Engine
Rather than relying on pre-packaged scraping frameworks or black-box aggregators, the core of the automated tracking relies on a bespoke string evaluation system. The engine reads the raw SMS payload line-by-line, matching bank-specific sender IDs and using strict regex logic to securely pull accurate financial data points. This architecture ensures absolute, granular control over how financial data is sanitized and structured before hitting the local database.

## Getting Started
### Prerequisites
- Flutter SDK (latest stable release)
- Dart SDK
- A physical mobile device or emulator.
