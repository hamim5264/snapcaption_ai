# SnapCaption AI

SnapCaption AI is a modern AI-powered mobile application that generates high-quality, human-like captions for travel, lifestyle, and product photos.  
It is designed to feel natural, platform-aware, and ready for real-world posting — not robotic or generic.

The project represents a complete end-to-end AI product, combining prompt engineering, backend API design, and a polished Flutter mobile experience.

---

## ✨ Key Features

- AI-generated **title, description, and hashtags**
- Platform-aware writing:
  - Instagram
  - LinkedIn
  - Product / Marketing
- Multiple tone options:
  - Fun
  - Professional
  - Poetic
- Optional user-provided OpenAI API key
- Daily free usage limit when using default API
- Clean, glassmorphism-based UI
- Copy-ready output for instant posting
- No login required

---

## 🏗️ Architecture Overview

**Frontend**
- Flutter (single theme for light & dark)
- GetX for state management
- Glassmorphism UI components
- Camera & gallery image picker

**Backend**
- FastAPI
- OpenAI API integration
- Prompt-engineered caption generation
- JSON-only, schema-safe responses

---

## 🔗 API Overview

### Generate Caption

Generates an AI-powered **title**, **description**, and **hashtags** based on user input.

---

## 📥 Request Body

```json
{
  "platform": "instagram",
  "tone": "fun",
  "imageCount": 2,
  "context": "sunset beach, warm light",
  "userTitle": "",
  "userDescription": ""
}
```
## 📥 Request Body
```json
{
  "title": "When the light slows everything down",
  "description": "Warm waves, calm air, and a sunset that didn’t rush.",
  "hashtags": ["#BeachSunset", "#TravelMoments"]
}
```
## 🔐 Privacy & Security
1. No user authentication required
2. Photos are not stored permanently
3. User API keys (if provided) are stored locally on the device
4. Backend does not log or store personal user data
5. No tracking or analytics on generated content

## 🧪 Project Status
1. Phase 1: Complete (production-ready)
2. Backend: Deployed and stable
3. Flutter App: Integrated successfully
4. API tested via Swagger & Postman

## 🗺️ Future Roadmap
1. Image vision understanding (Phase 2)
2. Style memory per user
3. Multiple caption variations per request
4. Saved caption history
5. Advanced hashtag intelligence
6. User preference profiles

## 👨‍💻 Author
- MD. Abdul Hamim Leon
- Software Developer || Jr. Flutter Developer
- BeUp In Tech
- A concern of Betopia Group
- GitHub: https://github.com/hamim5264
- Portfolio: https://hamim-info.vercel.app
- LinkedIn: https://www.linkedin.com/in/abdul-hamim-a35b02253/
  
## 📄 License & Usage
This project is protected under copyright law.

Restrictions

No unauthorized redistribution

No resale without written permission

Allowed Use

Personal use

Educational use

Commercial Use

Requires authorization from the author

For licensing, collaboration, or commercial usage, please contact the author directly.

## 📝 Final Note

SnapCaption AI was built with a strong focus on real-world usability, clean architecture, and responsible AI design.
It is not a demo or prototype — it is a complete, deployable AI product ready for users and developers alike.

Thank you for checking out the project.

## Screnshots
<img width="3375" height="3375" alt="1" src="https://github.com/user-attachments/assets/6cded019-eb85-4a5a-aa82-ce86ee22886d" />
<img width="3375" height="3375" alt="2" src="https://github.com/user-attachments/assets/fc462772-d828-47c4-9d6b-d6547e0f4dd9" />


