
#!/bin/bash
# EOEX Store: Automated End-to-End Workflow Script
# Usage: bash eoex-store-saves.sh <stage>

set -e

REPO="https://github.com/eoextrainer/eoex-test-store.git"
PROJECT_DIR="$(pwd)"

function save_and_push() {
  local msg="$1"
  git add .
  git commit -m "$msg"
  git push origin develop
}

function init_project() {
  git init || true
  git remote add origin "$REPO" 2>/dev/null || true
  git checkout -b main || git checkout main
  for branch in develop feature fix test ready archive int qa prod; do
    git branch | grep -q $branch || git checkout -b $branch
  done
  git push --all origin
  echo "Project initialized and all branches pushed."
}

function scaffold_backend() {
  cd "$PROJECT_DIR/backend"
  python3 -m venv venv
  source venv/bin/activate
  pip install fastapi uvicorn sqlalchemy pydantic mysql-connector-python
  pip freeze > requirements.txt
  deactivate
  cd "$PROJECT_DIR"
  ./scripts/save-backend-scaffold.sh || true
  save_and_push "Scaffold backend API"
}

function scaffold_database() {
  ./scripts/save-database-scaffold.sh || true
  save_and_push "Add database schema and seed"
}

function scaffold_frontend() {
  cd "$PROJECT_DIR/frontend"
  npm install || true
  cd "$PROJECT_DIR"
  ./scripts/save-frontend-scaffold.sh || true
  save_and_push "Scaffold app store frontend"
}

function scaffold_mobile() {
  cd "$PROJECT_DIR/frontend"
  # Cordova/Capacitor setup assumed
  ./scripts/save-frontend-scaffold.sh || true
  cd "$PROJECT_DIR"
  save_and_push "Scaffold hybrid mobile app"
}

function dockerize() {
  ./scripts/save-dockerize.sh || true
  save_and_push "Add Docker Compose setup"
}

function document() {
  ./scripts/save-docs.sh || true
  save_and_push "Add documentation"
}

function finalize() {
  ./scripts/save-test-finalize.sh || true
  save_and_push "Finalize and test project"
}

function update_backend_deps() {
  cd "$PROJECT_DIR/backend"
  source venv/bin/activate
  pip freeze > requirements.txt
  deactivate
  cd "$PROJECT_DIR"
  save_and_push "Update backend requirements"
}

function update_frontend_deps() {
  cd "$PROJECT_DIR/frontend"
  npm install
  npm audit fix --force
  cd "$PROJECT_DIR"
  save_and_push "Update frontend dependencies"
}

function verify_db() {
  docker exec -it $(docker ps -qf "name=db") mysql -u root -p -e "SHOW TABLES; SELECT * FROM user;"
}

case "$1" in
  init) init_project ;;
  backend) scaffold_backend ;;
  database) scaffold_database ;;
  frontend) scaffold_frontend ;;
  mobile) scaffold_mobile ;;
  dockerize) dockerize ;;
  docs) document ;;
  finalize) finalize ;;
  update-backend) update_backend_deps ;;
  update-frontend) update_frontend_deps ;;
  verify-db) verify_db ;;
  *)
    echo "Usage: $0 {init|backend|database|frontend|mobile|dockerize|docs|finalize|update-backend|update-frontend|verify-db}"
    exit 1
    ;;
esac
