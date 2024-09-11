FROM node:18-bullseye

ENV TERM=xterm

# Install dependencies
RUN apt-get update && apt-get install -y \
    software-properties-common \
    python3.9 \
    python3.9-distutils \
    python3-pip

WORKDIR /app

COPY ./src/services/recommendations/requirements.txt requirements.txt

RUN pip3 install -r requirements.txt

COPY package*.json ./

RUN npm install

COPY . .

CMD [ "npm", "run", "start" ]
