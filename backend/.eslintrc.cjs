/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Julien Letoux <julien.letoux@epitech.eu>
*/

const header = [
  '',
  '** Copyright GETOUT SAS - All Rights Reserved',
  '** Unauthorized copying of this file, via any medium is strictly prohibited',
  '** Proprietary and confidential',
  {
    pattern: 'Writed by [\\A-zÀ-ú ]+ <[\\w.-]+@\\w+\\.\\w+>$',
    template: '** Writed by Firstname Lastname <firstname.lastname@domain.com>'
  },
  ''
]

module.exports = {
  env: {
    browser: false,
    es2021: true
  },
  extends: [
    'eslint:recommended',
    'plugin:@typescript-eslint/recommended'
  ],
  parser: '@typescript-eslint/parser',
  parserOptions: {
    ecmaVersion: 'latest',
    sourceType: 'module',
    tsconfigRootDir: __dirname,
    project: ['./tsconfig.json']
  },
  plugins: [
    '@typescript-eslint',
    'header',
    'eslint-plugin-import-helpers'
  ],
  rules: {
    'no-unused-vars': ['warn', { vars: 'all', args: 'none', ignoreRestSiblings: false }],
    '@typescript-eslint/no-unused-vars': ['warn', { vars: 'all', args: 'none', ignoreRestSiblings: false }],
    '@typescript-eslint/no-explicit-any': 'off',
    'object-curly-spacing': ["error", "always"],
    'header/header': ['error', 'block', header, 2],
    '@typescript-eslint/no-non-null-assertion': 'off',
    'import-helpers/order-imports': [
      'warn',
      {
        newlinesBetween: 'always',
        groups: [
          'module',
          '/^@middlewares/',
          '/^@services/',
          '/^@models/',
          '/^@entities/',
          '/^@routes/',
          '/^@config/',
          ['parent', 'sibling', 'index'],
          '/^~/'
        ],
        alphabetize: { order: 'asc', ignoreCase: true }
      }
    ]
  }
}
