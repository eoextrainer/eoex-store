from fastapi import FastAPI
from routers import users, apps

app = FastAPI()
app.include_router(users.router)
app.include_router(apps.router)

@app.get("/")
def read_root():
    return {"message": "Welcome to the eoex-app-store-01 API"}
