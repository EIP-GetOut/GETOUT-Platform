/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

declare global {
  namespace NodeJS {
    interface ProcessEnv {
      NODE_ENV: 'development' | 'production' | 'test'
      PORT: number
      ORIGIN_PATTERN: string
      LOG_FILENAME: string
      RECOMMENDATIONS_INTERVAL_SECONDS: number
      SESSION_SECRET: string

      TYPEORM_PORT: number
      TYPEORM_HOST: string
      TYPEORM_USERNAME: string
      TYPEORM_PASSWORD: string
      TYPEORM_DATABASE: string

      GOOGLE_CLIENT_ID: string
      GOOGLE_BOOKS_API_KEY: string
      MOVIE_DB_KEY: string
      BREVO_API_KEY: string
    }
  }
}

// If this file has no import/export statements (i.e. is a script)
// convert it into a module by adding an empty export statement.
export {}
