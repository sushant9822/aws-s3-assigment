# Project- phoenix

## Getting Started

Follow these steps to set up and run the application on your local machine.

### Prerequisites

- **Python 3.x** (ensure it's installed by running `python --version`)
- **Git** (to clone the repository)

### Installation

1. **Clone the repository**  
   Clone the repository to your local machine:
   ```bash
   git https://github.com/sushant9822/s3-assignment-aws.git
   cd s3-assignment-aws
   ```

2. **Install dependencies**
    Install the required packages listed in requirements.txt:
    ```bash
    pip install -r requirements.txt
    ```

3. **Set up environment variables**
Create a .env file in the root directory of the project and Use the below format:
```bash
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_REGION=
S3_BUCKET_NAME=
```
4. **Running the Application**
Run the application locally using:
```bash
python app.py
```

## Running with Docker
1. **Build the Docker image**
Build the Docker image using the provided Dockerfile:
```bash 
docker build -t your-image-name .
```
2. **Run the Docker container**
Run the application in a container:
```bash
docker run --env-file .env -p 8000:8000 your-image-name
```
