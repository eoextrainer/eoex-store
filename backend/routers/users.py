from fastapi import APIRouter, HTTPException
from pydantic import BaseModel

router = APIRouter(prefix="/users", tags=["users"])

class User(BaseModel):
    username: str
    password: str

@router.post("/register")
def register(user: User):
    # TODO: Add user registration logic
    return {"message": f"User {user.username} registered."}

@router.post("/login")
def login(user: User):
    # TODO: Add authentication logic
    return {"message": f"User {user.username} logged in."}
