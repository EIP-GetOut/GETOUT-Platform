FROM node:16

ENV TERM=xterm

RUN apt-get update || : && apt-get install python python3-pip -y

# CMD ["tail", "-f", "/dev/null"]

RUN pip3 install tmdbv3api

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

CMD [ "npm", "run", "start" ]
