from fastapi import APIRouter

router = APIRouter(prefix="/apps", tags=["apps"])

@router.get("")
def list_apps():
    # TODO: Fetch apps from database
    return [
        {"id": 1, "name": "App One", "description": "First app"},
        {"id": 2, "name": "App Two", "description": "Second app"},
        {"id": 3, "name": "App Three", "description": "Third app"},
    ]
