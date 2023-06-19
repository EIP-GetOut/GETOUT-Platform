---
title: API Reference

language_tabs: # must be one of https://git.io/vQNgJ
  - javascript
  - shell

toc_footers:
  - <a href='#'>Sign Up for a Developer Key</a>
  - <a href='https://github.com/slatedocs/slate'>Documentation Powered by Slate</a>

includes:
  - errors

search: true

code_clipboard: true

meta:
  - name: description
    content: Documentation for the internal Area API
---

# Introduction

Welcome to the internal GetOut!

`POST http://localhost:8080/account HTTP/1.1`

```javascript
router.post('/account', rulesPost, validate, logApiRequest)
```
> The above command returns JSON structured like this:

Register a new account by mail, Google(GoogleToken), Github(githubToken), Facebook(FacebookToken)

`router.post('/account')`

## Patch

> PATCH

```json
{
  "firstName": "GG",
  "lastName": "SOSTRONG",
  "bornDate": "11/11/1984"
}
```

`PATCH http://localhost:9000/account HTTP/1.1`

```javascript
router.patch('/account', rulesPatch, validate, logApiRequest)
```

> The above command returns JSON structured like this:

Changes an account parameter.

`router.patch('/account')`



## Delete

`DEL http://localhost:9000/account HTTP/1.1`

```javascript
router.delete('/account', rulesDelete, validate, logApiRequest)
```

> The above command returns JSON structured like this:

```json
{
  "id": 2,
  "deleted" : "true"
}
```

Delette an account using its ID

`router.delete('/account')`

## Login

> LOGIN

`POST http://localhost:9000/account/login HTTP/1.1`

```javascript
router.post('/account/login')
```

> The above command returns this:

> 204 No content.

Login to an account.

`router.login('/account')`

## Logout

> LOGOUT

`POST http://localhost:9000/account/logout HTTP/1.1`

```javascript
router.post('/account/logout')
```

> The above command returns this:

> 204 No content.

Logout to an account.

`router.logout('/account')`