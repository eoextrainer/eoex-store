from fastapi import FastAPI
from app.api import router as api_router

app = FastAPI(title="EOEX Store Backend API", version="v1.0.0")

app.include_router(api_router)

@app.get("/")
def root():
    return {"message": "Welcome to EOEX Store Backend API"}
