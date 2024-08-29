# GovTech OA for CFT Intern Submission - Darren Chan

Live app deployed on DigitalOcean App Platform at 
[govtech-oa.darren-chan.com](https://govtech-oa.darren-chan.com)  

Backend deployed on DigitalOcean Droplet at 
[govtech-oa-backend.darren-chan.com](https://govtech-oa-backend.darren-chan.com)

## Table of Contents

1. [Testing and Coverage](#testing-and-coverage)
2. [API Documentation](#api-documentation)
   - [1. Add Numbers](#1-add-numbers)
   - [2. Subtract Numbers](#2-subtract-numbers)
3. [Dependencies](#dependencies)
4. [To Run (Locally)](#to-run-locally)
   - [Frontend](#frontend)
   - [Backend](#backend)
5. [To Run (Production)](#to-run-production)
   - [Frontend](#frontend-1)
   - [Backend](#backend-1)
6. [What I Learned](#what-i-learned)


## Testing and Coverage
Performed simple unit tests and routing tests with RSpec to achieve 100% code coverage on the backend

![image](https://github.com/user-attachments/assets/94ea2b9e-dba5-4c0b-b3d0-0f65f4786c53)


## API Documentation

### 1. Add Numbers

**Endpoint:** `/api/v1/add`  
**Method:** `POST`  

**Content-Type:** `application/x-www-form-urlencoded`  

**Parameters:**
- `first` (string): The first number to add.
- `second` (string): The second number to add.

**Request Example:**
```
POST /api/v1/add
Content-Type: application/x-www-form-urlencoded

first=5&second=10
```

**Response:**
- `result` (string): The result of the addition.

**Response Example:**
```
{
  "result": "15"
}
```

---

### 2. Subtract Numbers

**Endpoint:** `/api/v1/subtract`  
**Method:** `POST`  

**Content-Type:** `application/x-www-form-urlencoded`  

**Parameters:**
- `first` (string): The number to subtract from.
- `second` (string): The number to subtract.

**Request Example:**
```
POST /api/v1/subtract
Content-Type: application/x-www-form-urlencoded

first=10&second=5
```

**Response:**
- `result` (string): The result of the subtraction.

**Response Example:**
```
{
  "result": "5"
}
```
## Dependencies
- Docker
- npm

## To Run (Locally)

### Frontend
1. Clone the repository.
2. Navigate to the `frontend` directory:
    ```bash
    cd frontend/
    ```
3. Install dependencies and start the development server:
    ```bash
    npm i
    npm start
    ```

**Note:** The `RAILS_ENV_BACKEND_URL` environment variable must be set to the URL of the hosted backend (e.g., `http://localhost:3000` if you are running locally).

### Backend
1. Navigate to the `backend` directory:

    ```bash
    cd backend/
    ```
3. Build the Docker image:

    ```bash
    sudo docker build .
    ```
4. Run the Docker container:

   ```bash
    sudo docker run -p 3000:3000 -e RAILS_ENV=development <imagehash>
    ```

## To Run (Production)

### Frontend
Same as development.

### Backend
1. **If your frontend is running SSL:** Generate your own Let's Encrypt certificate and ensure that the `RAILS_ENV_BACKEND_URL` environment variable is set to the correct URL that you have chosen.

2. Comment out the following line in the Dockerfile (Line 61):
    ```Dockerfile
    CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
    ```

3. Uncomment the following line (Line 64):
    ```Dockerfile
    CMD ["./bin/rails", "server"]
    ```

4. Run the Docker container:
    ```bash
    docker run -d -v /etc/letsencrypt:/etc/letsencrypt -p 443:3001 <image hash here>
    ```

## What I Learned
- Docker is amazing.
- You can't have a web app running on SSL making an API call using HTTP (Mixed Content).

