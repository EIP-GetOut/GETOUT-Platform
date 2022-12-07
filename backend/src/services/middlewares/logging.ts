/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import morgan from 'morgan'
import winston from 'winston'
import 'winston-daily-rotate-file'

winston.addColors({
  error: 'bold red',
  warn: 'bold yellow',
  info: 'bold blue',
  http: 'bold cyan',
  verbose: 'bold brown',
  debug: 'bold grey',
  silly: 'bold purple'
})

const logger: winston.Logger = winston.createLogger({
  level: 'http',
  transports: [
    new winston.transports.DailyRotateFile({
      filename: process.env.LOG_FILENAME,
      datePattern: 'YYYY-MM-DD-HH',
      zippedArchive: process.env.NODE_ENV !== 'development',
      maxSize: '100m',
      maxFiles: '30d'
    }),
    new winston.transports.Console({
      level: 'debug',
      handleExceptions: true,
      format: winston.format.combine(
        winston.format.timestamp({
          format: 'YY-MM-DD HH:mm:ss'
        }),
        winston.format.printf(info =>
          winston.format.colorize().colorize(info.level, `[${info.timestamp}] [${info.level}] ${info.message}`)
        ))
    })
  ],
  exitOnError: false
})

const morganConf = {
  format: ':remote-addr :remote-user | :method :url | :status',
  options: {
    stream: {
      write: (message: string) => logger.http(message.trim())
    }
  }
}

// function createMorganToken () {
//   morgan.token('email', (req: Request, res: Response) => req.session?.account?.email ?? '-')
// }

// TODO: change type
const logApiRequest: any = morgan(morganConf.format, morganConf.options)

export { logger as default, logApiRequest }
