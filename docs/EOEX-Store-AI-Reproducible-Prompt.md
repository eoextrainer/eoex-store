# EOEX Store: Complete AI Reproducible Project Prompt

## Objective
Generate a complete, production-ready web and hybrid mobile/web application for the EOEX App Store (or a user-specified app name), including backend, frontend, database, Dockerization, and DevOps workflows.

---

## Step-by-Step Implementation

### 1. Project Initialization
- Prompt for the app name, project folder, author, contributors, and version.
- Change directory to the project folder.
- Initialize a git repository if not present.
- Create a README.md with project metadata.
- Create a Python virtual environment (`python3 -m venv venv`).
- Save the VSCode workspace.
- Create branches: main, develop, feature, fix, test, ready, archive, int, qa, prod.
- Prompt for the remote repository URL and push all branches.
- Create a workflow automation script `[app-name]-saves.sh` to automate save, stash, stage, commit, push, pull request, and merge request.

### 2. Project Structure
- Create folders: `/frontend`, `/backend`, `/database`, `/docs`, `/scripts`.
- Add `.gitignore` files to each folder as appropriate.

### 3. Frontend (React Native + Web)
- Scaffold a React Native project with Expo in `/frontend`.
- Add dependencies: `react`, `react-dom`, `react-native`, `react-native-web`, `react-navigation`, etc.
- Implement:
  - Splash screen (animated EOEX Netflix-style)
  - Home screen (Netflix-style UI, hero, carousel, features, FAQ, footer)
  - Carousels, secure auth, deep linking, theme context
- Ensure the app runs in both Chrome (web) and Android emulator (mobile).
- Add a Dockerfile for the frontend.

### 4. Backend (FastAPI)
- Scaffold a FastAPI project in `/backend`.
- Add dependencies: `fastapi`, `uvicorn`, `sqlalchemy`, `pydantic`, `mysql-connector-python`, etc.
- Implement endpoints for user management, authentication, app listing, and admin features.
- Connect to the MySQL database.
- Add a Dockerfile for the backend.

### 5. Database (MySQL)
- Create `schema.sql` and `seed.sql` in `/database` for users, apps, and store tables.
- Add a Dockerfile for the database service.


### 6. Dockerization
- Create a `docker-compose.yml` at the project root to orchestrate all services.
- Ensure all services can be built and run together.
- **Automatically install Docker Compose if not present before starting services.**

### 7. Documentation
- Add README.md to each major folder with setup, usage, and workflow instructions.
- Document the workflow automation scripts in `/scripts`.

### 8. Testing & Finalization
- Provide instructions to run the app in Chrome (web) and Android emulator (mobile).
- Test all endpoints and UI features.
- Use save/restart scripts at each stage to ensure resumability.

---

## Example Save/Restart Scripts
- `eoex-store-saves.sh`: Main workflow automation script.
- `scripts/save-initialize-structure.sh`: Save project structure.
- `scripts/save-frontend-scaffold.sh`: Save frontend scaffold.
- `scripts/save-frontend-splash.sh`: Save splash screen implementation.
- `scripts/save-frontend-home.sh`: Save home screen implementation.
- `scripts/save-backend-scaffold.sh`: Save backend scaffold.
- `scripts/save-database-scaffold.sh`: Save database scaffold.
- `scripts/save-dockerize.sh`: Save Dockerization.
- `scripts/save-docs.sh`: Save documentation.
- `scripts/save-test-finalize.sh`: Save testing/finalization.

---

## Docker Compose Example
```
version: '3.8'
services:
  frontend:
    build: ./frontend
    ports:
      - "8080:8080"
    depends_on:
      - backend
    environment:
      - NODE_ENV=production
  backend:
    build: ./backend
    ports:
      - "8000:8000"
    depends_on:
      - db
    environment:
      - MYSQL_HOST=db
      - MYSQL_USER=root
      - MYSQL_PASSWORD=root
      - MYSQL_DB=eoex_app_store_01
  db:
    build: ./database
    ports:
      - "3306:3306"
    environment:
      - MYSQL_DATABASE=eoex_app_store_01
      - MYSQL_ROOT_PASSWORD=root
    volumes:
      - db_data:/var/lib/mysql
volumes:
  db_data:
```

---


## Reproducibility
- At every major stage, use the corresponding save/restart script to save, commit, and push changes.
- All code, configuration, and documentation files are generated as described.
- The project is ready-to-run as a monorepo with Docker Compose.
- The backend's `requirements.txt` is always updated with `pip freeze` after dependency changes.
- The frontend's `package-lock.json` is always updated with `npm install` and `npm audit fix --force` after dependency changes.
- MySQL root password is set to `root` for local development. Update `.env` and Docker Compose as needed for production.
- Database schema and seed are verified by checking tables and initial data after container startup.

---


## To Reproduce This Project
1. Follow the step-by-step implementation above.
2. Use the provided save/restart scripts at each stage.
3. Build and run all services with Docker Compose.
4. After backend dependency changes, run `pip freeze > requirements.txt` in the backend container and copy it to the host.
5. After frontend dependency changes, run `npm install` and `npm audit fix --force` in the frontend container and commit the updated `package-lock.json`.
6. Verify MySQL root password and database name in Docker Compose and `.env` files.
7. After startup, verify database schema and seed by connecting to the db container and running `SHOW TABLES;` and `SELECT * FROM user;`.
8. Refer to the documentation in each folder for details.

---

*This prompt can be used by an AI agent to fully reproduce the EOEX Store project end-to-end, including all technical details, scripts, and workflow automation.*
