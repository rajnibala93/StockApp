# 📈 iOS Stock App

A simple iOS application that displays stock market data using Yahoo Finance APIs. The app shows a list of stocks with real-time updates and allows users to view detailed information for each stock.

---

## 🚀 Features

- 📋 Display list of stocks (name, price, symbol)
- 🔍 Search stocks by name
- 📄 Stock detail screen
- 🔄 Auto-refresh every 8 seconds
- ⏳ Loading and error state handling
- 🧠 MVVM architecture
- 🔗 Dependency Injection using Swinject
- ⚡ Reactive programming using Combine
- 🧪 Unit tests for ViewModels

---

## 🛠 Tech Stack

- SwiftUI
- Combine
- Swinject
- MVVM Architecture

---

## 📂 Project Structure
StocksApp
├── App
├── DI
├── Models
├── Network
├── Services
├── ViewModels
├── Views
└── Tests

---

## ▶️ Setup Instructions

1. Clone the repository: 
2. Open the project in Xcode:
3. Add your RapidAPI key in `Endpoint.swift`:
"X-RapidAPI-Key": "YOUR_API_KEY"
4. Run the project (⌘ + R)

---

🧪 Running Tests
Open Xcode
Press ⌘ + U to run unit tests

---

🧠 Architecture

The app follows MVVM (Model-View-ViewModel):

View → SwiftUI UI layer
ViewModel → Business logic and state
Service → API interaction
APIClient → Network layer

---

Data Flow
View → ViewModel → Service → APIClient → API

---

👤 Author
Rajni Bala
