
# EOEX Store: End-to-End Implementation Plan (v1.0.0-beta)

---

## Changelog

- **v1.0.0-beta** (2025-12-17):
  - Finalized EOEX Store home screen with 10 cover images, Play Store-inspired design, and full compliance with EOEX Store Design.
  - Save/push workflow automated and reproducible.

---

## 1. Project Initialization

### 1.1. Setup & Git Workflow
- Clone the repo or initialize if new:
  ```bash
  git clone https://github.com/eoextrainer/eoex-test-store.git
  cd eoex-mob-app-01
  git init
  ```
- Create branches:
  ```bash
  git checkout -b main
  git checkout -b develop
  git checkout -b feature
  git checkout -b fix
  git checkout -b test
  git checkout -b ready
  git checkout -b archive
  git checkout -b int
  git checkout -b qa
  git checkout -b prod
  ```
- Set remote and push:
  ```bash
  git remote add origin https://github.com/eoextrainer/eoex-test-store.git
  git push --all origin
  ```
- Create a main workflow script `eoex-store-saves.sh` to automate save, commit, push, and PR.

---

## 2. Project Structure
- Ensure folders: `/frontend`, `/backend`, `/database`, `/docs`, `/scripts` exist.
- Add `.gitignore` to each as needed.

---

## 3. Backend API (Python FastAPI + MySQL)
- Scaffold FastAPI in `/backend`.
- Add dependencies: `fastapi`, `uvicorn`, `sqlalchemy`, `pydantic`, `mysql-connector-python`.
- Implement endpoints:
  - User management
  - Authentication
  - App listing (with download links)
  - Admin features
- Connect to MySQL (use `/database` schema).
- Add Dockerfile for backend.
- Save progress:
  ```bash
  ./scripts/save-backend-scaffold.sh
  git add backend/ scripts/save-backend-scaffold.sh
  git commit -m "Scaffold backend API"
  git push origin develop
  ```

---

## 4. Database (MySQL)
- Create `schema.sql` and `seed.sql` in `/database` for users, apps, store tables.
- Add Dockerfile for MySQL service.
- Save progress:
  ```bash
  ./scripts/save-database-scaffold.sh
  git add database/ scripts/save-database-scaffold.sh
  git commit -m "Add database schema and seed"
  git push origin develop
  ```

---

## 5. App Store Frontend (Web)
- Use HTML, CSS, JS (Bootstrap/Tailwind) in `/frontend`.
- Enforce Play Store-like design and color scheme (see EOEX Store Design.docx).
- Implement:
  - App tiles with hover glow
  - Platform detection (JS)
  - Download links per platform
  - Responsive layout
- Add Dockerfile for frontend.
- Save progress:
  ```bash
  ./scripts/save-frontend-scaffold.sh
  git add frontend/ scripts/save-frontend-scaffold.sh
  git commit -m "Scaffold app store frontend"
  git push origin develop
  ```

---

## 6. Hybrid Mobile App (Cordova/Capacitor)
- Scaffold Cordova/Capacitor project in `/frontend` or `/mobile`.
- Use minimal HTML/JS/CSS frontend.
- Bundle SQLite for local storage.
- Implement API integration to backend.
- Build for Android (APK), iOS (IPA), Windows Phone (APPX).
- Save progress:
  ```bash
  ./scripts/save-frontend-scaffold.sh
  git add frontend/ scripts/save-frontend-scaffold.sh
  git commit -m "Scaffold hybrid mobile app"
  git push origin develop
  ```

---

## 7. Dockerization
- Create `docker-compose.yml` at root to orchestrate frontend, backend, db.
- Ensure all services build and run together.
- Save progress:
  ```bash
  ./scripts/save-dockerize.sh
  git add docker-compose.yml scripts/save-dockerize.sh
  git commit -m "Add Docker Compose setup"
  git push origin develop
  ```

---

## 8. Documentation
- Add README.md to each major folder.
- Document all scripts in `/scripts`.
- Save progress:
  ```bash
  ./scripts/save-docs.sh
  git add docs/ scripts/save-docs.sh
  git commit -m "Add documentation"
  git push origin develop
  ```

---

## 9. Testing & Finalization
- Test web app in browser and Android emulator.
- Test mobile app on emulator and real devices.
- Use save/restart scripts at each stage.
- Save progress:
  ```bash
  ./scripts/save-test-finalize.sh
  git add scripts/save-test-finalize.sh
  git commit -m "Finalize and test project"
  git push origin develop
  ```

---

## 10. Platform-Specific Download/Install
- Android: Direct APK download, show install guide.
- iOS: IPA with sideload/TestFlight/AltStore instructions.
- Windows Phone: APPX with sideload instructions.
- Use JS to detect platform and show correct guide.

---

## 11. Deployment
- Deploy web app to a free public server (Vercel, Render, or free VPS).
- Update download links as needed.

---

## 12. Reproducibility & Workflow
- At every major stage, use the corresponding save script.
- Always commit and push to remote.
- After backend dependency changes:
  ```bash
  pip freeze > backend/requirements.txt
  git add backend/requirements.txt
  git commit -m "Update backend requirements"
  git push origin develop
  ```
- After frontend dependency changes:
  ```bash
  npm install
  npm audit fix --force
  git add frontend/package-lock.json
  git commit -m "Update frontend dependencies"
  git push origin develop
  ```
- Verify MySQL root password and DB name in Docker Compose and `.env`.
- After startup, verify DB schema and seed:
  ```bash
  docker exec -it <db_container> mysql -u root -p
  SHOW TABLES;
  SELECT * FROM user;
  ```

---

*This plan ensures a reproducible, production-ready EOEX Store project with seamless save, commit, and push workflows, enforcing the design and architecture requirements.*
