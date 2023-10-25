/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

interface volumeInfo {
  title?: string
  authors?: string[]
  publisher?: string
  publishedDate?: string
  readingModes?: { text: boolean, image: boolean }
  pageCount?: number
  printedPageCount?: number
  dimensions?: { height: string }
  printType?: string
  maturityRating?: string
  allowAnonLogging?: boolean
  contentVersion?: string
  panelizationSummary?: { containsEpubBubbles: boolean, containsImageBubbles: boolean }
  language?: string
  previewLink?: string
  infoLink?: string
  canonicalVolumeLink?: string
  imageLinks?: { thumbnail: string }
  description?: string
}

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
