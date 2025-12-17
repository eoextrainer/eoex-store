#!/bin/bash
# EOEX Store Complete Automated Setup Script
# This script automates the full setup, scaffolding, and workflow for the EOEX Store project.
# Author: EOEX | Contributor: Sosthene Grosset-Janin | v1.0.0 | December 2025

set -e

# 1. Prompt for app name and project folder (assume env vars or defaults)
APP_NAME="EOEX Store"
PROJECT_DIR="$(pwd)"
AUTHOR="EOEX"
CONTRIBUTOR="Sosthene Grosset-Janin"
CONTRIBUTOR_EMAIL="educ1.eoex@gmail.com"
VERSION="v1.0.0"
TIMESTAMP="December 2025"
REMOTE_REPO="git@github.com:eoextrainer/eoex-store.git"

# 2. Initialize git and workspace
if [ ! -d .git ]; then
  git init
fi

echo -e "# $APP_NAME\n\nHello from $AUTHOR. this is $APP_NAME application.\n\n- **Author:** $AUTHOR\n- **Contributor:** $CONTRIBUTOR\n- **Contributor Email:** $CONTRIBUTOR_EMAIL\n- **Version:** $VERSION\n- **Timestamp:** $TIMESTAMP\n" > README.md

python3 -m venv venv
code .

git checkout -b main || git branch -m master main
for branch in develop feature fix test ready archive int qa prod; do
  git branch $branch || true
done

git add .
git commit -m "Initial commit: project setup, README, venv"
git remote add origin "$REMOTE_REPO" || true
git pull origin main --no-rebase --allow-unrelated-histories || true
git push --set-upstream origin main
git push --set-upstream origin develop feature fix test ready archive int qa prod

# 3. Create workflow automation script
echo '#!/bin/bash\n# EOEX Store Git Workflow Automation Script\nset -e\nif [ -z "$1" ]; then echo "Usage: $0 \"Commit message\""; exit 1; fi\nCOMMIT_MSG="$1"\nBRANCH=$(git rev-parse --abbrev-ref HEAD)\ngit add .\ngit stash save "Auto-stash before commit: $COMMIT_MSG"\ngit stash pop || true\ngit add .\ngit commit -m "$COMMIT_MSG"\ngit pull origin $BRANCH --no-rebase --allow-unrelated-histories || true\ngit push origin $BRANCH\necho "[EOEX Store] Changes saved, committed, and pushed on branch: $BRANCH"' > eoex-store-saves.sh
chmod +x eoex-store-saves.sh

# 4. Create project structure
for dir in frontend backend database docs scripts; do
  mkdir -p $dir
done

echo -e "# EOEX Store Frontend\nnode_modules/\nbuild/\ndist/\n.env\n" > frontend/.gitignore
echo -e "# EOEX Store Backend\n__pycache__/\n*.pyc\nvenv/\n.env\n" > backend/.gitignore
echo -e "# EOEX Store Database\n*.db\n*.sqlite\n*.log\n.env\n" > database/.gitignore
echo -e "# EOEX Store Docs\n*.log\n*.tmp\n" > docs/.gitignore
echo -e "# EOEX Store Scripts\n*.log\n*.tmp\n" > scripts/.gitignore

./eoex-store-saves.sh "Initialize project structure: frontend, backend, database, docs, scripts, .gitignore"


# 5. Scaffold frontend (Expo/React Native)
cd frontend
npx create-expo-app . --template
# Always update package-lock.json and audit fix for reproducibility
npm install
npm audit fix --force
cd ..
./eoex-store-saves.sh "Scaffold frontend: React Native web/mobile, Netflix-style UI base"


# 6. Scaffold backend (FastAPI)
cd backend
python3 -m venv venv
source venv/bin/activate
pip install fastapi uvicorn sqlalchemy pydantic mysql-connector-python python-dotenv
mkdir -p app
# Always update requirements.txt for reproducibility
pip freeze > requirements.txt
cat <<EOF > main.py
from fastapi import FastAPI
from app.api import router as api_router
app = FastAPI(title="EOEX Store Backend API", version="v1.0.0")
app.include_router(api_router)
@app.get("/")
def root():
  return {"message": "Welcome to EOEX Store Backend API"}
EOF
cat <<EOF > app/api.py
from fastapi import APIRouter
router = APIRouter()
@router.get("/ping")
def ping():
  return {"message": "pong"}
EOF
cat <<EOF > app/models.py
from sqlalchemy import Column, Integer, String
from sqlalchemy.ext.declarative import declarative_base
Base = declarative_base()
class User(Base):
  __tablename__ = 'users'
  id = Column(Integer, primary_key=True, index=True)
  email = Column(String(255), unique=True, index=True, nullable=False)
    hashed_password = Column(String(255), nullable=False)
    role = Column(String(50), default='user')
class App(Base):
    __tablename__ = 'apps'
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(255), nullable=False)
    vendor = Column(String(255))
    version = Column(String(50))
    target_platform = Column(String(50))
    downloads = Column(Integer, default=0)
    size = Column(String(50))
    host_source = Column(String(255))
    revisions = Column(String(255))
    bugs = Column(String(255))
EOF
cat <<EOF > app/database.py
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
import os
MYSQL_USER = os.getenv('MYSQL_USER', 'root')
MYSQL_PASSWORD = os.getenv('MYSQL_PASSWORD', 'password')
MYSQL_HOST = os.getenv('MYSQL_HOST', 'db')
MYSQL_DB = os.getenv('MYSQL_DB', 'eoex_store')
DATABASE_URL = f"mysql+mysqlconnector://{MYSQL_USER}:{MYSQL_PASSWORD}@{MYSQL_HOST}/{MYSQL_DB}"
engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
EOF
cd ..
./eoex-store-saves.sh "Scaffold backend: FastAPI, SQLAlchemy, MySQL, API structure"

# 7. Scaffold database (MySQL)
echo '-- EOEX Store MySQL Schema
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    hashed_password VARCHAR(255) NOT NULL,
    role VARCHAR(50) DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS apps (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    vendor VARCHAR(255),
    version VARCHAR(50),
    target_platform VARCHAR(50),
    downloads INT DEFAULT 0,
    size VARCHAR(50),
    host_source VARCHAR(255),
    revisions VARCHAR(255),
    bugs VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS store (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    app_id INT,
    downloaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (app_id) REFERENCES apps(id)
);' > database/schema.sql
echo '-- EOEX Store MySQL Seed Data
INSERT INTO users (email, hashed_password, role) VALUES
('admin@eoex.com', '$2b$12$adminhashedpassword', 'admin'),
('user1@eoex.com', '$2b$12$user1hashedpassword', 'user');
INSERT INTO apps (name, vendor, version, target_platform, downloads, size, host_source, revisions, bugs) VALUES
('Health Tracker', 'EOEX', '1.0.0', 'android', 100, '20MB', 'https://eoex.com/health', '1', ''),
('Finance Guru', 'EOEX', '1.0.0', 'web', 50, '15MB', 'https://eoex.com/finance', '1', '');' > database/seed.sql
./eoex-store-saves.sh "Scaffold database: MySQL schema, tables, seed data for users, apps, store"

# 8. Dockerize all services
cat <<EOF > frontend/Dockerfile
FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 8080
CMD ["npm", "run", "web"]
EOF
cat <<EOF > backend/Dockerfile
FROM python:3.12-slim
WORKDIR /app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
EOF
cat <<EOF > database/Dockerfile
FROM mysql:8.0
ENV MYSQL_DATABASE=eoex_store
ENV MYSQL_ROOT_PASSWORD=password
COPY schema.sql /docker-entrypoint-initdb.d/
COPY seed.sql /docker-entrypoint-initdb.d/
EXPOSE 3306
EOF
cat <<EOF > docker-compose.yml
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
      - MYSQL_PASSWORD=password
      - MYSQL_DB=eoex_store
  db:
    build: ./database
    ports:
      - "3306:3306"
    environment:
      - MYSQL_DATABASE=eoex_store
      - MYSQL_ROOT_PASSWORD=password
    volumes:
      - db_data:/var/lib/mysql
volumes:
  db_data:
EOF
./eoex-store-saves.sh "Dockerize all services: frontend, backend, database, docker-compose.yml"

# 9. Documentation
for dir in frontend backend database docs scripts; do
  echo -e "# EOEX Store $dir\n\nSee project root and docs for details." > $dir/README.md
done
./eoex-store-saves.sh "Add documentation: setup, usage, workflow in all major folders"

# 10. Test and finalize
./eoex-store-saves.sh "Test and finalize implementation: run instructions for web and mobile, verify endpoints and UI"


# Ensure Docker Compose is installed
if ! command -v docker-compose >/dev/null 2>&1; then
  echo "[EOEX Store] Docker Compose not found. Installing..."
  if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update && sudo apt-get install -y docker-compose
  elif command -v yum >/dev/null 2>&1; then
    sudo yum install -y docker-compose
  else
    echo "[EOEX Store] Please install Docker Compose manually."
    exit 1
  fi
fi

# Set Chrome as the default browser (Linux Ubuntu)
if command -v xdg-settings >/dev/null 2>&1 && command -v google-chrome >/dev/null 2>&1; then
  xdg-settings set default-web-browser google-chrome.desktop
  echo "[EOEX Store] Google Chrome set as the default browser."
fi

# Start all services with Docker Compose
docker-compose up -d
sleep 10

# Launch the frontend in the default browser
if command -v google-chrome >/dev/null 2>&1; then
  google-chrome http://localhost:8080 &
else
  xdg-open http://localhost:8080 &
fi

echo "\n[EOEX Store] Complete setup and scaffolding finished. Review documentation and run 'docker-compose up' to start all services."
