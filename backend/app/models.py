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
