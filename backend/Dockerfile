FROM node:16

ENV TERM=xterm

RUN apt-get update || : && apt-get install python python3-pip -y

WORKDIR /app

COPY ./src/services/recommandations/requirements.txt requirements.txt

RUN pip3 install -r requirements.txt

COPY package*.json ./

RUN npm install

COPY . .

CMD [ "npm", "run", "start" ]
