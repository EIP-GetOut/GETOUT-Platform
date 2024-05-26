/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

interface saleInfo {
  country: string
  saleability: string
  isEbook: boolean
}

interface accessInfo {
  country: string
  viewability: string
  embeddable: boolean
  publicDomain: boolean
  textToSpeechPermission: string
  epub: { isAvailable: boolean }
  pdf: { isAvailable: boolean }
  webReaderLink: string
  accessViewStatus: string
  quoteSharingAllowed: boolean
}

export interface BookResult {
  kind?: string
  id?: string
  etag?: string
  selfLink?: string
  volumeInfo?: volumeInfo
  saleInfo?: saleInfo
  accessInfo?: accessInfo
}

export interface BooksResults {
  kind: string
  totalItems: number
  items: BookResult []
}
