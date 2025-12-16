
# EOEX App Store - AI Application Generation Prompt (Enhanced)

## Objective
Generate a complete, production-ready web and hybrid mobile/web application for the EOEX App Store (or a user-specified app name), including backend, frontend, database, Dockerization, and DevOps workflows, using the following requirements and detailed step-by-step implementation.

---

## User Input
- **Prompt:** _Please provide the name of the app to be created:_

---

## Project Information
- **Project Name:** [User-provided]
- **Brand:** EOEX
- **Subtitle:** App Store
- **Author:** EOEX
- **Contributor:** Sosthene Grosset-Janin (sgrosset.consulting@gmail.com)
- **Client:** EOEX Digital
- **Objectives:** Implement and deliver an end-to-end web and hybrid mobile/web application that hosts various mobile applications to be downloaded and can be run from both the Android emulator and the local Chrome browser.

---

## Requirements
1. **Project Structure:**
        - `/frontend` (React Native for hybrid mobile/web, Netflix-style UI, see below)
        - `/backend` (Python FastAPI)
        - `/database` (MySQL, user table with admin/user roles)
        - Dockerized for all services
        - Git with custom workflow and branch structure
2. **Frontend:**
        - Use the provided React Native Netflix-style UI template (see `eoex-app-frontend-template.txt`)
        - Splash screen, home screen, carousels, secure auth, deep linking, theme context, and all features as described
        - Must run as a web app (Chrome) and as a mobile app (Android emulator)
        - Use HTML, CSS, JavaScript, and React Native (with web support via `react-native-web`)
3. **Backend:**
        - Python FastAPI with endpoints for user management and app listing
        - Connect to MySQL database
        - Use Python and relevant dependencies (FastAPI, SQLAlchemy, etc.)
4. **Database:**
        - MySQL with `user` table (admin, user roles)
        - Default admin user
        - Provide SQL schema and seed data
5. **DevOps:**
        - Docker Compose for all services
        - Git workflow automation script (`app-changes.sh`)
        - Branches: main, develop, feature, fix, test, ready, archive, prod, int, qa
        - At each implementation stage, execute `app-changes.sh` to commit and document progress
6. **Documentation:**
        - README.md for each major folder
        - Markdown documentation for setup, usage, and workflows

---

## Step-by-Step Implementation

### 1. Initialize Project Structure
- Create the following folders: `/frontend`, `/backend`, `/database`, `/docs`, `/scripts`
- Initialize a Git repository and set up the required branch structure
- Add `.gitignore` files as needed
- **Run:** `./scripts/app-changes.sh "Initialize project structure"`

### 2. Frontend Setup (Hybrid Web & Mobile)
- Scaffold a React Native project with web support (`react-native-web`)
- Add dependencies: `react`, `react-dom`, `react-native`, `react-native-web`, `react-navigation`, etc.
- Implement the Netflix-style UI using the provided template
- Add HTML, CSS, and JavaScript files as needed for web compatibility
- Implement splash screen, home, carousels, authentication, deep linking, and theme context
- Ensure the app runs in both Chrome (web) and Android emulator (mobile)
- **Run:** `./scripts/app-changes.sh "Implement frontend hybrid app"`

#### Example Source Code (Frontend)
```javascript
// App.js
import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import MainNavigator from './src/navigation/MainNavigator';

export default function App() {
    return (
        <NavigationContainer>
            <MainNavigator />
        </NavigationContainer>
    );
}
```
```css
/* styles.css */
.carousel {
    display: flex;
    overflow-x: auto;
    /* ... */
}
```

### 3. Backend Setup (API)
- Scaffold a FastAPI project in Python
- Add dependencies: `fastapi`, `uvicorn`, `sqlalchemy`, `pydantic`, `mysql-connector-python`, etc.
- Implement endpoints for user registration, authentication, app listing, and admin features
- Connect to the MySQL database
- **Run:** `./scripts/app-changes.sh "Implement backend API"`

#### Example Source Code (Backend)
```python
# main.py
from fastapi import FastAPI
from routers import users, apps

app = FastAPI()
app.include_router(users.router)
app.include_router(apps.router)

@app.get("/")
def read_root():
        return {"message": "Welcome to the EOEX App Store API"}
```

### 4. Database Setup
- Create MySQL schema and tables (user, apps, etc.)
- Add seed data for default admin and sample apps
- Provide SQL scripts for schema and seed
- **Run:** `./scripts/app-changes.sh "Setup database schema and seed data"`

#### Example Source Code (Database)
```sql
-- init.sql
CREATE TABLE user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('admin', 'user') DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO user (username, password_hash, role) VALUES ('admin', '<hashed_password>', 'admin');
```

### 5. Dockerization
- Write Dockerfiles for frontend, backend, and database
- Create a `docker-compose.yml` to orchestrate all services
- Ensure all services can be built and run together
- **Run:** `./scripts/app-changes.sh "Add Docker and Compose files"`

#### Example Source Code (Docker Compose)
```yaml
version: '3.8'
services:
    frontend:
        build: ./frontend
        ports:
            - "3000:3000"
    backend:
        build: ./backend
        ports:
            - "8000:8000"
    db:
        image: mysql:8
        environment:
            MYSQL_ROOT_PASSWORD: root
            MYSQL_DATABASE: eoex_store
        ports:
            - "3306:3306"
        volumes:
            - ./database/init.sql:/docker-entrypoint-initdb.d/init.sql
```

### 6. DevOps & Workflow Automation
- Implement the `app-changes.sh` script to automate Git workflow, commit, and push at each stage
- Document the workflow in Markdown
- **Run:** `./scripts/app-changes.sh "Document and automate workflow"`

#### Example Source Code (app-changes.sh)
```bash
#!/bin/bash
# Usage: ./app-changes.sh "commit message"
git add .
git commit -m "$1"
git push
```

### 7. Testing & Execution
- Provide instructions to run the app in Chrome (web) and Android emulator (mobile)
- Test all endpoints and UI features
- **Run:** `./scripts/app-changes.sh "Test and finalize implementation"`

---

## Dependencies
- **Frontend:** react, react-dom, react-native, react-native-web, react-navigation, styled-components, axios, etc.
- **Backend:** fastapi, uvicorn, sqlalchemy, pydantic, mysql-connector-python, etc.
- **Database:** MySQL 8+
- **DevOps:** Docker, Docker Compose, Git

---

## Instructions for AI
- Prompt the user for the app name and use it throughout the project.
- Generate all code, configuration, and documentation files required for a full-stack EOEX App Store (or user-specified app) as described above.
- Use the provided frontend template for all UI/UX and component structure.
- Ensure all Docker, backend, and database files are compatible and ready to run.
- Implement the Git workflow and automation script as described.
- At each major implementation stage, execute `app-changes.sh` to commit and document progress.
- Output the project as a ready-to-run monorepo.

---

## Reference
- See `/media/eoex/DOJO/CONSULTING/PROJECTS/eoex-store/frontend/eoex-app-frontend-template.txt` for the full UI/UX template.

---

*Prompt enhanced on 16 December 2025 for EOEX Digital.*
