# 🍲 Recipe Finder App

## 📄 Project Overview and Structure

**Recipe Finder** is a SwiftUI app that allows users to search, view, and favorite recipes using TheMealDB API. The architecture follows MVVM+C (Model-View-ViewModel + Coordinator) for clear separation of concerns, testability, and scalability.

**Key Structure:**
- `Modules/` — Feature-based folders (RecipeList, RecipeDetail, Favorites, Profile, etc.)
- `Services/` — Networking, storage, and repository layers (API, SwiftData, Favorites, etc.)
- `Models/` — UI and data models (Recipe, RecipeDetail, etc.)
- `Supporting/` — App entry, dependencies, and shared resources
- `Resources/` — Assets and strings

**Responsibilities:**
- **Coordinators** manage navigation and module assembly
- **ViewModels** handle business logic and state
- **Repositories** abstract data sources (API, local storage)
- **SwiftData** provides offline support for favorites

---

## 📊 Metrics

| Metric                        | Description/Value                         |
|-------------------------------|-------------------------------------------|
| ⏳ Estimated time without AI   | 18–24 hours                               |
| 🕒 Actual time with AI         | 8–10 hours                                 |
| 🤖 Time spent interacting with AI | 7.5–9.5 hours                              |
| 🧩 AI tools used               | Cursor, ChatGPT                           |

---

## 💬 Top 3 Effective Prompts

1. **"Lets move futher. Now I'd like to create a favorites feature. First of all we need some kind of storage. Lets use for this purposes SwiftData. Also I'd like to be able to fetch favorites data without internet and user should be able to open a receipe without internet. For this purposes we should to seperate models, we should have different models for netwokr, for local storage and for UI First of all lets create Local storage layer with usage of SwiftData"**
   - *Result:* High-level overview of current plans. Clear plan of creating local storage layer.

2. **"Lets create StorageManager protocol and implementation for SwiftData, and a FavoritesLocalRepository that uses it."**
   - *Result:* Generated a clean, testable abstraction for local storage, with protocol-based dependency injection.

3. **"Lets add a favorite button to the recipe cell and wire up the logic for adding/removing favorites."**
   - *Result:* Provided a step-by-step plan and code for integrating favorite toggling, including UI and view model changes.

---

## 🧱 1–2 Ineffective Prompts

1. **Prompt:** "Can we use the default SwiftUI TextField clear button?"
   - *Issue:* The AI initially suggested it was possible, but later clarified that SwiftUI does not have a built-in clear button, requiring a custom solution or UIKit bridging.

2. **Prompt:** "Why do I get 'Type of expression is ambiguous without a type annotation'?"
   - *Issue:* The AI gave a general answer, but the real fix required seeing the specific line of code. More context was needed for a precise solution.

---

## 🧠 Reflection

**What went well:**
- Rapid prototyping and architecture setup with AI guidance
- Clean separation of concerns
- SwiftData integration for offline favorites was smooth
- AI helped with best practices, error handling, and refactoring

**What could be improved:**
- Some state sync issues (e.g., favorites updates) required manual intervention
- Occasional need for more context or clarification in prompts
- SwiftData quirks (e.g., array storage) needed extra research

**Key takeaways:**
- AI is excellent for scaffolding, best practices, and rapid iteration
- Human review is still essential for edge cases, state management, and platform-specific quirks
- Combining AI with modular architecture leads to maintainable, scalable apps

**Note:** Approximately 98% of the code in this project was written by AI (Cursor/ChatGPT), with the user focusing on review, integration, and minor adjustments.