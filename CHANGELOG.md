# Changelog

All notable changes to this project will be documented in this file. See [standard-version](https://github.com/conventional-changelog/standard-version) for commit guidelines.

### [0.6.2](https://github.com/EIP-GetOut/GETOUT-Platform/compare/v0.6.1...v0.6.2) (2024-08-15)


### Features

* **backend:** :sparkles: get news route and swagger doc without unit tests ([a98a907](https://github.com/EIP-GetOut/GETOUT-Platform/commit/a98a907bfc48f20112326cd759821287aa0e02eb))


### Bug Fixes

* :bug: home page dasboard wrong height ([6f5db00](https://github.com/EIP-GetOut/GETOUT-Platform/commit/6f5db00d7d43e6aa05fe689a2e3bb0f60c9d6f22))

### [0.6.1](https://github.com/EIP-GetOut/GETOUT-Platform/compare/v0.6.0...v0.6.1) (2024-08-15)


### Features

* **app:** :sparkles: add a function to convert seconds in good duration format, also re add static informations for the news (temporary) ([8f37b1f](https://github.com/EIP-GetOut/GETOUT-Platform/commit/8f37b1f5bc2df73aa177a8fa34e45ed2281d1e21))
* **app:** :sparkles: add a snackbar to display a message when code is incorrect ([093321e](https://github.com/EIP-GetOut/GETOUT-Platform/commit/093321e5373cf332e1be4d2a32212ed58416be61))
* **app:** :sparkles: add email verification with code, with page sucess and redirection to dashboard or forms, add a button to resend email if needed with a cooldown ([1edd40e](https://github.com/EIP-GetOut/GETOUT-Platform/commit/1edd40ecfe260416908282ad379c9d7ed5c8cfd4))
* **app:** :sparkles: add generic input and display entire errors (on forms) ([cd86917](https://github.com/EIP-GetOut/GETOUT-Platform/commit/cd8691741908dc7249f417c9683769bdccde232f))
* **app:** :sparkles: add some ui, clean code ([17fd1a0](https://github.com/EIP-GetOut/GETOUT-Platform/commit/17fd1a057b66741de090d2313958a5650cd5629f))
* **app:** :sparkles: add ui of the new elements of the dashboard (refresh time, spend, time, news) ([73905df](https://github.com/EIP-GetOut/GETOUT-Platform/commit/73905df6649798872fd86c7f0c2b505e015e5fde))
* **app:** :sparkles: adding edit email page (everything ready, just need the correct route) ([c6e98c0](https://github.com/EIP-GetOut/GETOUT-Platform/commit/c6e98c0b0bfed267095eeaef3b005d7278bd4ca7))
* **app:** :sparkles: adding edit password page (everything ready, just need the correct route) ([ed3ab34](https://github.com/EIP-GetOut/GETOUT-Platform/commit/ed3ab3419e98ae800bfe60ad9cfae53d11c8e906))
* **app:** :sparkles: adding valid request for the change password feature ([27c9570](https://github.com/EIP-GetOut/GETOUT-Platform/commit/27c9570060a45c8bd481f1ff7f6241e74b732b5c))
* **app:** :sparkles: applying l10n almost everywhere ([cbd1cd7](https://github.com/EIP-GetOut/GETOUT-Platform/commit/cbd1cd7a8ef6f40069332df5b8add17ce15b8b63))
* **app:** :sparkles: connect back to new ui for dashboard ([e8d1121](https://github.com/EIP-GetOut/GETOUT-Platform/commit/e8d112112ddb3a74e53395f7cab3b69c4ae1203b))
* **app:** :sparkles: create generic button widget, change all buttons by this widget ([45127af](https://github.com/EIP-GetOut/GETOUT-Platform/commit/45127afcc8a26b3b2f1ef89b2c36137dc58fbf11))
* **app:** :sparkles: create generic title ([34efc38](https://github.com/EIP-GetOut/GETOUT-Platform/commit/34efc383133ee242d39c3f7fc83a23bbe95964de))
* **backend:** :sparkles: caching of movie and book recommendations ([0914a2c](https://github.com/EIP-GetOut/GETOUT-Platform/commit/0914a2c443a5fbf5a8b72fb6256940e753b22c8c))
* **backend:** :sparkles: cronjob for inactivity emails ([d1f24d3](https://github.com/EIP-GetOut/GETOUT-Platform/commit/d1f24d35b277eefa053d55fe4683c69753a35e6c))
* **backend:** :sparkles: daily info route and tests ([3978614](https://github.com/EIP-GetOut/GETOUT-Platform/commit/3978614317d42780100bee0df2039b2474f67a08))
* **backend:** :sparkles: get the preferences of an user ([b5a5e96](https://github.com/EIP-GetOut/GETOUT-Platform/commit/b5a5e9690bf12230bb05c9a3bc50631debf5a95b))
* **backend:** :sparkles: getting the number of accounts created the week before ([9dcf4e8](https://github.com/EIP-GetOut/GETOUT-Platform/commit/9dcf4e8c76e62636c13b15735d20c719cee1915f))
* **backend:** :sparkles: getting the number of recommendations generated for the week ([c5c62a6](https://github.com/EIP-GetOut/GETOUT-Platform/commit/c5c62a6adf52979627d5b32c5513ef7ed938b0a8))
* **backend:** :sparkles: new variables in session for time before recommandation and time spent watching / reading ([6bd658b](https://github.com/EIP-GetOut/GETOUT-Platform/commit/6bd658b1546ed3db2ab23b07728d08b9902202ab))
* **backend:** :sparkles: resend email verification and email verification fixes ([937c63c](https://github.com/EIP-GetOut/GETOUT-Platform/commit/937c63c44be948d06b4fa485516e315add0d2971))
* **backend:** :sparkles: service google books ([d617d05](https://github.com/EIP-GetOut/GETOUT-Platform/commit/d617d05677d25d461eaae19a210b5b7b32f3c9f0))
* **backend:** :sparkles: tmdb service ([9c8b01c](https://github.com/EIP-GetOut/GETOUT-Platform/commit/9c8b01cceae50369666964135685f04fef88cc92))


### Bug Fixes

* **app:** :art: removing useless trues and adding const to some events ([3b76e44](https://github.com/EIP-GetOut/GETOUT-Platform/commit/3b76e44e1b3981e604f6f7fc3fdf6b917eae3d1c))
* **app:** :bug: books display due to bad type ([ac310ce](https://github.com/EIP-GetOut/GETOUT-Platform/commit/ac310ced25f4005c455c7999c635f94182eb2d61))
* **app:** :bug: fixing error handling of the login ([afa0cc7](https://github.com/EIP-GetOut/GETOUT-Platform/commit/afa0cc706f32d64fe9fa121a48eaf9954c9543c8))
* **app:** :bug: fixing view problem of movie details and book details ([aea3d18](https://github.com/EIP-GetOut/GETOUT-Platform/commit/aea3d18b447d98d1537c68bc3e9fa7ddb6cef1f0))
* **app:** :bug: movies and books (liked / saved) wasn't display to due to error (field change in request), clean code, add some error handling ([90c4bbc](https://github.com/EIP-GetOut/GETOUT-Platform/commit/90c4bbcb01267dd15467066a698498a8e63d9177))
* **app:** :bug: Session refresh every 15 seconds, recommandation time at 0 seconds, and books genres ([896a072](https://github.com/EIP-GetOut/GETOUT-Platform/commit/896a072ee6821535f5f3beaa56ed643ee4f02a9b))
* **app:** :bug: source author wasn't correctly display for story news due to bad condition ([3966b3f](https://github.com/EIP-GetOut/GETOUT-Platform/commit/3966b3f36386e1657894f43923bb3fb732b9a898))
* **app:** :bug: the text of the validator error was STILL too long ([f9e972f](https://github.com/EIP-GetOut/GETOUT-Platform/commit/f9e972f872891408228dfa059bfe6e523126910f))
* **app:** :bug: the text of the validator error was too long ([23ceb8e](https://github.com/EIP-GetOut/GETOUT-Platform/commit/23ceb8ecdbeb9497b590541f8d98ee5d31226758))
* **app:** :pencil2: typo on movie url variable name ([3fb8482](https://github.com/EIP-GetOut/GETOUT-Platform/commit/3fb848280740445b272d41045aafae7f41802b7c))
* **backend:** :bug: email templates ids ([c0de95f](https://github.com/EIP-GetOut/GETOUT-Platform/commit/c0de95f68eee63f1c4abc25d5b5d7eaf9363c008))
* **backend:** :bug: error catching reset password send email route ([8a6edb3](https://github.com/EIP-GetOut/GETOUT-Platform/commit/8a6edb3fdfa7a29815101d875e8f2e2bcc290022))
* **backend:** :bug: missing return for session without connected account ([3ca29b4](https://github.com/EIP-GetOut/GETOUT-Platform/commit/3ca29b4edfcf9b9ab4908b51de7358d76c722e70))
* **backend:** :bug: permission route ([7192ed3](https://github.com/EIP-GetOut/GETOUT-Platform/commit/7192ed37cdc3a025ca7c7258a2a7f65adbd51414))


### Refactors

* :recycle: removed unused console.logs ([82315bb](https://github.com/EIP-GetOut/GETOUT-Platform/commit/82315bb3a15fa0228f206b8a460900cf99acb89a))
* **app:** :art: change some code to resolve some comments on pull request ([beeda75](https://github.com/EIP-GetOut/GETOUT-Platform/commit/beeda75e4fada78a4d0d9f079d708da915359145))
* **backend:** :ambulance: readded all previous contents lists in the session for easier frontend integration ([adcd6cb](https://github.com/EIP-GetOut/GETOUT-Platform/commit/adcd6cb04f9486e1c84df3c8616478a3f34e831d))
* **backend:** :recycle: change the response of book details and recommendations ([19abee9](https://github.com/EIP-GetOut/GETOUT-Platform/commit/19abee9d73ac3c0e5cab6365bc0a196f802525d7))
* **backend:** :recycle: getBook and getMovie direct properties instead of "book" and "movie"'s keys in response ([1e575b1](https://github.com/EIP-GetOut/GETOUT-Platform/commit/1e575b1ad45ee73c69ea244b1641b9c11abd1cc0))
* **backend:** :recycle: model funcs for recommend-movie and recommend-books route and redisClient singleton ([10a508a](https://github.com/EIP-GetOut/GETOUT-Platform/commit/10a508adb59d07ae0c23dcc937856dd922fc7501))
* **backend:** :sparkles: source string for daily infos ([44715f2](https://github.com/EIP-GetOut/GETOUT-Platform/commit/44715f2032be305cc451264b0dbe09ce980e27ac))

## [0.6.0](https://github.com/EIP-GetOut/GETOUT-Platform/compare/v0.5.5...v0.6.0) (2024-07-04)


### Features

* **backend:** :sparkles: all emails, beta signup, brevo service ([c9ee857](https://github.com/EIP-GetOut/GETOUT-Platform/commit/c9ee85745435cb32cedc311547f93fc663ec5bd9))
* **backend:** :sparkles: patch account ([1277c6c](https://github.com/EIP-GetOut/GETOUT-Platform/commit/1277c6ceecf96937492c6e42074ef6fb13df3d8a))
* **backend:** :sparkles: patch account by ids ([eb65bf8](https://github.com/EIP-GetOut/GETOUT-Platform/commit/eb65bf828550889dba3764325047dcbfd1bfd38a))
* **backend:** :sparkles: patch news for the panel admin ([fda0ade](https://github.com/EIP-GetOut/GETOUT-Platform/commit/fda0ade27c5de4c8eb5c59e2081ada6c32fc6e9e))


### Bug Fixes

* **backend:** :bug: readBooks in Account entity and response of a PATCH /account ([ea39298](https://github.com/EIP-GetOut/GETOUT-Platform/commit/ea39298ae1a80bad34b0be690aebb7dd12a73585))
* **backend:** :rotating_light: linting error ([bf88b5d](https://github.com/EIP-GetOut/GETOUT-Platform/commit/bf88b5d1bae5aa635bcb674347f4032767dea0fe))


### UI Updates

* **backend:** :rotating_light: linting unordered import ([a20f0ec](https://github.com/EIP-GetOut/GETOUT-Platform/commit/a20f0ec97f33644b3b1fb48afe8b13383af1ca8a))


### Refactors

* **backend:** :recycle: recommendations algorithms books and movies ([5ed8a6c](https://github.com/EIP-GetOut/GETOUT-Platform/commit/5ed8a6cef86feff3082b4c8757f709eeff745de8))
* **backend:** :recycle: session object and account mapping to session ([900e898](https://github.com/EIP-GetOut/GETOUT-Platform/commit/900e89868f67b3df5e4be3e3e5c0373dcce4b615))

### [0.5.5](https://github.com/EIP-GetOut/GETOUT-Platform/compare/v0.5.4...v0.5.5) (2024-05-27)


### Features

* **app:** :sparkles: adding more movie genre in the form ([c434dcc](https://github.com/EIP-GetOut/GETOUT-Platform/commit/c434dcc76ecb0bdbdac04f872283927f391e7d57))
* **backend:** :sparkles: verify email route without actually sending the email ([85138a6](https://github.com/EIP-GetOut/GETOUT-Platform/commit/85138a6113998df6709f65313c97a726790575e9))

### [0.5.4](https://github.com/EIP-GetOut/GETOUT-Platform/compare/v0.5.2...v0.5.4) (2024-05-26)


### Features

* **backend:** :sparkles: delete specific user by ID and return the backend version on the base route ([e8c2068](https://github.com/EIP-GetOut/GETOUT-Platform/commit/e8c2068cf88296a4a322da3489996fee6c3d14ad))


### Bug Fixes

* **backend:** :bug: authors pictures undefined ([d9e56ad](https://github.com/EIP-GetOut/GETOUT-Platform/commit/d9e56ad7df1366c8a318ceb8ac6d50c0811388e6))
* **backend:** :bug: recommendations pool of movies fetched ([c6db164](https://github.com/EIP-GetOut/GETOUT-Platform/commit/c6db1648c6f203b5366683bba3bee60c468cb2fb))

### [0.5.3](https://github.com/EIP-GetOut/GETOUT-Platform/compare/v0.5.2...v0.5.3) (2024-05-26)


### Bug Fixes

* **backend:** :bug: authors pictures undefined ([d9e56ad](https://github.com/EIP-GetOut/GETOUT-Platform/commit/d9e56ad7df1366c8a318ceb8ac6d50c0811388e6))
* **backend:** :bug: recommendations pool of movies fetched ([c6db164](https://github.com/EIP-GetOut/GETOUT-Platform/commit/c6db1648c6f203b5366683bba3bee60c468cb2fb))

### [0.5.2](https://github.com/EIP-GetOut/GETOUT-Platform/compare/v0.5.1...v0.5.2) (2024-05-26)


### Features

* **app:** :construction: adding more choice for the form (problems images for streaming services) ([f9d7122](https://github.com/EIP-GetOut/GETOUT-Platform/commit/f9d712238f2c775711c26b8fb7429dedd1d30d35))
* **app:** :construction: adding more choice for the form (problems images for streaming services) ([81d7663](https://github.com/EIP-GetOut/GETOUT-Platform/commit/81d7663a42c29098f4feddc8e52ea5d2e51a0585))
* **app:** :sparkles: set repeat interval at every minutes for notifications system ([8a46257](https://github.com/EIP-GetOut/GETOUT-Platform/commit/8a46257663d62beb527159f6148a6da6364b09b6))


### Bug Fixes

* **app:** :art: removed unused import ([bab5675](https://github.com/EIP-GetOut/GETOUT-Platform/commit/bab5675df261a0d7605bf9884941a8a704fe11b9))
* **app:** :art: removed unused import ([b7fcf56](https://github.com/EIP-GetOut/GETOUT-Platform/commit/b7fcf56ecd806290fb482d1064719633ca25eb3c))
* **app:** :bug: clean flutter analysis. ([47619cf](https://github.com/EIP-GetOut/GETOUT-Platform/commit/47619cf4fc79d09988b8eb1f81ea417aca6ab32d))
* **app:** :bug: image name in pubspec ([61b7a99](https://github.com/EIP-GetOut/GETOUT-Platform/commit/61b7a997fb5d59b76387645d3c04692562fffe29))
* **app:** :lipstick: in the form, logos of streaming services are now same size, same radius and better quality ([ea97b46](https://github.com/EIP-GetOut/GETOUT-Platform/commit/ea97b46118c11288c98adf875f5b5670715cb1bc))
* **app:** :lipstick: in the form, logos of streaming services are now same size, same radius and better quality ([5d14144](https://github.com/EIP-GetOut/GETOUT-Platform/commit/5d14144432913847b17abffdb1b4c769cb5537f8))


### UI Updates

* **app:** :lipstick: change some ui ([582d3a5](https://github.com/EIP-GetOut/GETOUT-Platform/commit/582d3a5957d464b37f5185f9187b1ef0eb51276e))


### Refactors

* **backend:** :recycle: books genres to google books genres mapping, fixed single genre recommendation bug ([54172a5](https://github.com/EIP-GetOut/GETOUT-Platform/commit/54172a5fda42b0b24a15501780e6d66fcd48f3d5))

### [0.5.1](https://github.com/EIP-GetOut/GETOUT-Platform/compare/v0.5.0...v0.5.1) (2024-05-23)


### Features

* **app:** :sparkles: add a button for disconnect user ([6f8e80c](https://github.com/EIP-GetOut/GETOUT-Platform/commit/6f8e80ce1dece72b6b955b73d8384020ee9e00ca))
* **app:** :sparkles: add delete account page and request ([3a5a363](https://github.com/EIP-GetOut/GETOUT-Platform/commit/3a5a36398168f31b076ac3bfd549dd8c1e1c3687))
* **app:** :sparkles: add more l10n ([174cf37](https://github.com/EIP-GetOut/GETOUT-Platform/commit/174cf3768b2d019c2fda462197c8033e0e2244ee))
* **app:** :sparkles: add redirection to login page after disconnect ([10cd005](https://github.com/EIP-GetOut/GETOUT-Platform/commit/10cd0050c30c0f4dd3c526f5a77a3b92e4942d86))
* **app:** :sparkles: add small history for books & movies. ([fa668bb](https://github.com/EIP-GetOut/GETOUT-Platform/commit/fa668bbcb1f2fd03d161d2d667b4d8fc452c511d))
* **app:** :sparkles: add some errors handling for forgot password ([f10e852](https://github.com/EIP-GetOut/GETOUT-Platform/commit/f10e852e3d12d320d746c951fb7aa8957e96ca00))
* **app:** :sparkles: change request params ([6d499ca](https://github.com/EIP-GetOut/GETOUT-Platform/commit/6d499caa612af1b5811e7b327cc88c2dc3127828))
* **app:** :sparkles: redirect user to settings after refill forms ([8d94a40](https://github.com/EIP-GetOut/GETOUT-Platform/commit/8d94a402cff7039e261803d287b322d6be69b212))
* **app:** :twisted_rightwards_arrows: merge app into feature/deconnection ([a903f5a](https://github.com/EIP-GetOut/GETOUT-Platform/commit/a903f5afa3cb8ccf4fa86968657abe4ab37939ce))
* **backend:** :sparkles: welcome email and password reset email ([fd9066c](https://github.com/EIP-GetOut/GETOUT-Platform/commit/fd9066cd9362781cf984aaa35515abd3c269364b))


### Bug Fixes

* **app:** :bug: fix errors due to expanded (get session) ([db4d799](https://github.com/EIP-GetOut/GETOUT-Platform/commit/db4d7991c801930ed1b61845cb50d6bde804d03d))


### UI Updates

* **app:** :art: clean code,and fix issues from flutter analyze ([76e0590](https://github.com/EIP-GetOut/GETOUT-Platform/commit/76e059020839c5f192dbca4b24ebcc6e3860d8d3))
* **app:** :art: fix errors due to flutter analyze ([96dad12](https://github.com/EIP-GetOut/GETOUT-Platform/commit/96dad121795a0378c422219e6a1c0553bc0a45dc))
* **app:** :art: remove issues from flutter analyze ([2087610](https://github.com/EIP-GetOut/GETOUT-Platform/commit/20876101c3d0bea3af309e5d16ddb70b5bdb6bf0))
* **app:** :lipstick: change red color by green for interaction for movie and book ([5f056f4](https://github.com/EIP-GetOut/GETOUT-Platform/commit/5f056f486a7111fb5c666c1f141d9265cabcd53f))

## [0.5.0](https://github.com/EIP-GetOut/GETOUT-Platform/compare/v0.4.0...v0.5.0) (2024-05-22)


### Features

* :sparkles: books and movies recommendations ([fcba41b](https://github.com/EIP-GetOut/GETOUT-Platform/commit/fcba41b7e9b879c4d690b55e83d984ba9132070d))
* :sparkles: Check si les livres et films afficher dans les recommendation n'étaient pas dans les recommendation précedantes ([b7a78a8](https://github.com/EIP-GetOut/GETOUT-Platform/commit/b7a78a828bf5c2d98182d61bbccc2364770516c1))
* **app:** :arrow_up: :heavy_minus_sign: Upgrade dependencies and Android Gradle + deleting old dependencies ([22cf599](https://github.com/EIP-GetOut/GETOUT-Platform/commit/22cf599bcdaec44ed3735fd5b1d3d84cca0fbe1b))
* **app:** :art: add tools/validator(email, password) + constant/regex, remove oldCommentedErrorHandling, fix StatefullWidget->StatelessWidget ([5b30429](https://github.com/EIP-GetOut/GETOUT-Platform/commit/5b304295d1901be2674442b433e01fdcad4568ee))
* **app:** :iphone: form is now responsive (and have only 3 pages) ([920493a](https://github.com/EIP-GetOut/GETOUT-Platform/commit/920493a61e67e3e4200ec241c07cc9175fd00783))
* **app:** :sparkles: add director for movie and authors for books ([8314b6e](https://github.com/EIP-GetOut/GETOUT-Platform/commit/8314b6e50b6ac5d6e29af07c61e87ef8b054f3eb))
* **app:** :sparkles: add director for movie, authors for books ans share for books ([74cf3d9](https://github.com/EIP-GetOut/GETOUT-Platform/commit/74cf3d9cc9729d70d2106b2f88ca76a12dfa97b2))
* **app:** :sparkles: add like and dislike feature ([6408ab7](https://github.com/EIP-GetOut/GETOUT-Platform/commit/6408ab78c077e58335652c5cee83b84010210e4b))
* **app:** :sparkles: add reading book and wishlist for books ([6cdeb42](https://github.com/EIP-GetOut/GETOUT-Platform/commit/6cdeb422f748a988f59331ab061291318b852eea))
* **app:** :sparkles: add share link for books ([c73e834](https://github.com/EIP-GetOut/GETOUT-Platform/commit/c73e834e4827602c0947c095de7285fa9b1716fa))
* **app:** :sparkles: adding preferences request and put it in the login part ([a4d310d](https://github.com/EIP-GetOut/GETOUT-Platform/commit/a4d310d233ed7ebfc9408d3ee743fd2d3b8bbd24))
* **app:** :sparkles: birth date limit when you register (between 13 and 150 years old) ([885728b](https://github.com/EIP-GetOut/GETOUT-Platform/commit/885728b0590e98910ef2ae2df9f3141130a92f31))
* **app:** :sparkles: change more than 75% of static string with l10n ([812a68d](https://github.com/EIP-GetOut/GETOUT-Platform/commit/812a68d9acb088f3dfac5e21d92980a7e1b72732))
* **app:** :sparkles: edit services, setting_importance, language, (restore api_path) ([1df6190](https://github.com/EIP-GetOut/GETOUT-Platform/commit/1df6190a3ae3449d7c940b3250b3eaea4279908c))
* **app:** :sparkles: handle (parameters and book, movie,homepage, preview) with intl, I've forget some string ([551c0f9](https://github.com/EIP-GetOut/GETOUT-Platform/commit/551c0f9788414bde3338b93551a258608dd9f192))
* **app:** :sparkles: hydratedBloc to the application ([039657b](https://github.com/EIP-GetOut/GETOUT-Platform/commit/039657bc6aaed0145db1597cdf0c372857e4c2c1))
* **app:** :sparkles: merge with app can be transform in a PR. ([27b364f](https://github.com/EIP-GetOut/GETOUT-Platform/commit/27b364f36951a6604cac6eb90113f614f6fd290d))
* **app:** :sparkles: recommended movies and books request are now without preferences ([a00ad9a](https://github.com/EIP-GetOut/GETOUT-Platform/commit/a00ad9a8dcc26db9e86558f40dea24682e765598))
* **app:** :sparkles: setting, setting_row, account_info, (add responsive things) ([6c2863c](https://github.com/EIP-GetOut/GETOUT-Platform/commit/6c2863c2facb30116634dde52dd84dfdfc68c9ca))
* **app:** :twisted_rightwards_arrows: fix errors due to merge ([40b01fd](https://github.com/EIP-GetOut/GETOUT-Platform/commit/40b01fd58029716e4f6ad3dad2a3d80d1053b94d))
* **app:** ✨ add get session (with bloc) ([35cf168](https://github.com/EIP-GetOut/GETOUT-Platform/commit/35cf168ce817a94b549760ec46789ce66625cc3f))
* **app:** 📱 connection part (login, register, etc) is now responsive ([a84ff42](https://github.com/EIP-GetOut/GETOUT-Platform/commit/a84ff421e9e78cac3775d27729e816ccfe937031))
* **backend:** :label: updated session with all new fields of Account entity ([0f2987f](https://github.com/EIP-GetOut/GETOUT-Platform/commit/0f2987fe389a8b1607d32f43ab3b04590d204384))
* **backend:** :sparkles: book link ([7952ec1](https://github.com/EIP-GetOut/GETOUT-Platform/commit/7952ec18b43f4b018925ad794653e098aaf5d958))
* **backend:** :sparkles: books recommendations refresh ([3eb4529](https://github.com/EIP-GetOut/GETOUT-Platform/commit/3eb4529006bc8eec08969af172f894dea8d0a6e9))
* **backend:** :sparkles: delete account ([89958ef](https://github.com/EIP-GetOut/GETOUT-Platform/commit/89958efd7368011fc15ae32b6442861d7528c8e2))
* **backend:** :sparkles: director ([8ae4532](https://github.com/EIP-GetOut/GETOUT-Platform/commit/8ae4532a77ff3b693b96eb6c22212123aedd3faa))
* **backend:** :sparkles: disliking movie or book now removes It from liked list and vice versa ([6a5d023](https://github.com/EIP-GetOut/GETOUT-Platform/commit/6a5d023705b21f8ead778df4ff73fac3c6a1b700))
* **backend:** :sparkles: get similar movies from tmdb ([1bac00d](https://github.com/EIP-GetOut/GETOUT-Platform/commit/1bac00d44c0daf0ad23615832a6d1bcc0e710d6e))
* **backend:** :sparkles: new fields returned in the book details ([5bf617e](https://github.com/EIP-GetOut/GETOUT-Platform/commit/5bf617e3a946eca838cc7eab5a7092a039ffa20c))
* **backend:** :sparkles: number of user connected, accounts details with a page system and movie recommendations from tmdb ([c20a42b](https://github.com/EIP-GetOut/GETOUT-Platform/commit/c20a42b5b235ba451dc4248ad69fc57488abc00d))
* **backend:** :sparkles: recommandations history routes, use of google books's sdk, session refresh ([9a66dad](https://github.com/EIP-GetOut/GETOUT-Platform/commit/9a66dad3917e4cdee8cfc242ab448d62ce18b735))
* **backend:** :sparkles: Refresh of movies recommendations, auto session / account maping middleware ([5ada37d](https://github.com/EIP-GetOut/GETOUT-Platform/commit/5ada37d93e07deff90eba4133ec1bbd0d885a807))
* **backend:** :sparkles: seen movies and read books routes (GET, POST, DELETE) and logout all route. ([9bd69d5](https://github.com/EIP-GetOut/GETOUT-Platform/commit/9bd69d5b2ae4c42c58d3b812e898064c04db2ccc))
* **backend:** :sparkles: user permissions ([ee5d6da](https://github.com/EIP-GetOut/GETOUT-Platform/commit/ee5d6dacd980e633d180a7e9de1bc1096ccc0997))
* **recommandations:** :sparkles: add structure of the functions for the recommandation algorithm ([0f45f68](https://github.com/EIP-GetOut/GETOUT-Platform/commit/0f45f68e9d87c676d627499a29975a96b98165ff))
* **recommandations:** :sparkles: books are now given back with id ([905f082](https://github.com/EIP-GetOut/GETOUT-Platform/commit/905f0820c48a8e29003ed9eeba21ed618fcc038d))
* **recommandations:** :sparkles: books score are now properly evaluated ([172e501](https://github.com/EIP-GetOut/GETOUT-Platform/commit/172e501a889bbec53c5d509a2e6ddaa126abab08))
* **recommandations:** :sparkles: score calculation basic for books and movies ([e7f96fe](https://github.com/EIP-GetOut/GETOUT-Platform/commit/e7f96fea7da1e172e9395d5c3c88c0b962a7f717))


### Bug Fixes

* :bug: condition for recommendation with the history book / movie ([b575c99](https://github.com/EIP-GetOut/GETOUT-Platform/commit/b575c996cc1522db70978db19e20c3651b94fb58))
* **app:** :art: fix setting import ([443ba60](https://github.com/EIP-GetOut/GETOUT-Platform/commit/443ba601347c156d40fecb37bfb2356259063ab6))
* **app:** :art: remove useless function ([1620e1e](https://github.com/EIP-GetOut/GETOUT-Platform/commit/1620e1e10a941974618c14d4f0690bce454e1356))
* **app:** :bento: images are now organized (along with their path in the code) ([04841f4](https://github.com/EIP-GetOut/GETOUT-Platform/commit/04841f4b43041f0141d3607cad0d6f4b5ba31c04))
* **app:** :boom: :art: :zap: build settings(edit_password,edit_email) with lightweight architecture <3 ([60ae840](https://github.com/EIP-GetOut/GETOUT-Platform/commit/60ae84027df72982fd00532ee0273cb564172949))
* **app:** :bug: fix likedMoviesList & likedBooksList ([46bd8f9](https://github.com/EIP-GetOut/GETOUT-Platform/commit/46bd8f92bd6f1f5676bfbfd4af2bde1545310bd9))
* **app:** :bug: fix movieList & bookList ([2960448](https://github.com/EIP-GetOut/GETOUT-Platform/commit/29604483f7a73cedaace7fdee97aa05411505c5b))
* **app:** :bug: movies liked wasn't display to due bad cast ([e2172b1](https://github.com/EIP-GetOut/GETOUT-Platform/commit/e2172b1f920c3375f7301cb5e8446aa9f92423b6))
* **app:** :bug: remove line duplicata ([f07646f](https://github.com/EIP-GetOut/GETOUT-Platform/commit/f07646fe2ee13f0a91b6e521755bfc524cb2711f))
* **app:** :bug: savedBooks wasn't working on book page. ([a2fadf8](https://github.com/EIP-GetOut/GETOUT-Platform/commit/a2fadf879f07d769fc14dc197eebfd552cc5d5ef))
* **app:** :bug: set each validator with empty check & remove print ([cf52f90](https://github.com/EIP-GetOut/GETOUT-Platform/commit/cf52f9025a43ec717e9041ee74cbd1c8b7c01df7))
* **app:** :fire: remove service repo ([afa5ce8](https://github.com/EIP-GetOut/GETOUT-Platform/commit/afa5ce82974828e0eb7f2fb381369eaa76097f6c))
* **app:** :pencil2: fix typo ([bc05fa5](https://github.com/EIP-GetOut/GETOUT-Platform/commit/bc05fa525378c6722de1364cb4fb6879e5e80192))
* **app:** :pencil2: remove duplicate import ([52e86ef](https://github.com/EIP-GetOut/GETOUT-Platform/commit/52e86ef11c949891d652fd2edfbba14c4898ae2d))
* **app:** set localeBloc to french ([32b644e](https://github.com/EIP-GetOut/GETOUT-Platform/commit/32b644ed8e8cc324bf52b739ae24cca40651b71e))
* **backend:** :ambulance: useSession interface ([4802819](https://github.com/EIP-GetOut/GETOUT-Platform/commit/48028195965c3a011c4f3d33043c7fbd2e4d871c))
* **backend:** :bug: books recommendations return body and proper naming, axios instead of node-fetch ([b96501b](https://github.com/EIP-GetOut/GETOUT-Platform/commit/b96501b7b74ecc7809f283c97d6402eaa7976674))
* **backend:** :bug: google books api key env validation ([6edadf8](https://github.com/EIP-GetOut/GETOUT-Platform/commit/6edadf8fee38bb806698c7ea05b3178c43955510))
* **backend:** :bug: infinite loading while removing an account ([dc06c38](https://github.com/EIP-GetOut/GETOUT-Platform/commit/dc06c383159ffa5be46ffc0963c7a615aba216a7))
* **backend:** :bug: reset-password unauthentified and refactored account deleting ([88a67fb](https://github.com/EIP-GetOut/GETOUT-Platform/commit/88a67fbb868b3e09bfe4fec8fe21c8a74da8eb2b))
* **backend:** :bug: seenMovies and readBooks, session updating in all account's lists routes ([9488561](https://github.com/EIP-GetOut/GETOUT-Platform/commit/948856110095fc4531a6234e67171f80e1ad4f59))
* **backend:** response body of signup request ([4471393](https://github.com/EIP-GetOut/GETOUT-Platform/commit/447139315e45b26e9262268676e9b9630f4fc321))


### UI Updates

* **app:** :lipstick: add html parser for overview, remove overview in preview ([e206f78](https://github.com/EIP-GetOut/GETOUT-Platform/commit/e206f788bbaf6f42c958230744278ac11e94fa09))
* **app:** :lipstick: change text size and spacing ([80fce65](https://github.com/EIP-GetOut/GETOUT-Platform/commit/80fce65d022a8e307709884b13684e6be51aecb2))


### Refactors

* **app:** :art: change map<string, string> by a Person class ([9f8084f](https://github.com/EIP-GetOut/GETOUT-Platform/commit/9f8084f4fa3b2141c7514ade4441fedb99562705))
* **app:** :art: transform movie.id ?? -1 in movie.id! ([e57ae97](https://github.com/EIP-GetOut/GETOUT-Platform/commit/e57ae97af9646a5db710ecc8857d704a1e8c7719))
* **backend:** :fire: removed the body params firstName and lastName in reset-password/send-email route ([2e097fb](https://github.com/EIP-GetOut/GETOUT-Platform/commit/2e097fbaf0f86da8d51e9e8059282f153d002775))
* **backend:** :heavy_minus_sign: removed node-fetch and github oauth ([501551b](https://github.com/EIP-GetOut/GETOUT-Platform/commit/501551b9fe981b126c402b7647234f32ff160aa7))
* **backend:** :recycle: getMovieDetail and getBookDetail ([bc42274](https://github.com/EIP-GetOut/GETOUT-Platform/commit/bc42274f4b95b742ba79d24258eb6ff32398db94))
* **backend:** :recycle: loginAccount model, error handling, duration format, added spent time calculation ([4969097](https://github.com/EIP-GetOut/GETOUT-Platform/commit/49690970ea4c7f38aa56a110d2ac79e5bf0b3bf4))
* **backend:** :recycle: recommandations history now returns the full content ([a619f4e](https://github.com/EIP-GetOut/GETOUT-Platform/commit/a619f4e30339773c9a14c7176d3072e6a8e6a4fb))
* **backend:** :recycle: reset-password, unit tests, dependencies ([95ef08f](https://github.com/EIP-GetOut/GETOUT-Platform/commit/95ef08f155c6f6820289705d72cc24b9fee92211))
* **backend:** :recycle: returning null if there is no vote_average or release date ([1f11fd4](https://github.com/EIP-GetOut/GETOUT-Platform/commit/1f11fd4c24c42f10f06c143bdfa6d3ad2a5e6dfb))
* **merge:** merge dev inside my branch ([3a9b1eb](https://github.com/EIP-GetOut/GETOUT-Platform/commit/3a9b1eb29d1ff683d97d826055748f7298802e5a))
* **recommandations:** :art: cleaned code following PR comments ([cf1b090](https://github.com/EIP-GetOut/GETOUT-Platform/commit/cf1b090a5577b5f7f79680c85f0119e7f8cbc258))

## [0.4.0](https://github.com/EIP-GetOut/GETOUT-Platform/compare/v0.3.0...v0.4.0) (2024-01-29)


### Features

* :sparkles: add generateBook & infoBook ([fe21c69](https://github.com/EIP-GetOut/GETOUT-Platform/commit/fe21c69250b93504b24d2e3ddaedc255145278aa))
* :sparkles: adding authors name and picture for book description ([0964dde](https://github.com/EIP-GetOut/GETOUT-Platform/commit/0964ddeaeecc439af9f11381ff8ed5ddf0587847))
* **app:** :art: every event is now in const ([4d2160f](https://github.com/EIP-GetOut/GETOUT-Platform/commit/4d2160f56a2bb0ca3446203f51d54baa854f86e5))
* **app:** :bug: fixing merge problem ([81d4894](https://github.com/EIP-GetOut/GETOUT-Platform/commit/81d489469091b1b82d754b01187a5e0a37404092))
* **app:** :construction: adding basic services for sending the forms ([4b0a31f](https://github.com/EIP-GetOut/GETOUT-Platform/commit/4b0a31fa14657965b363d01f54c9ab5fce2f3ee5))
* **app:** :lipstick: adding the last page of the form ([a136d8d](https://github.com/EIP-GetOut/GETOUT-Platform/commit/a136d8d9692568ccbf001cb584aa4f2c4e30c9cb))
* **app:** :sparkles: add casting name / Image ([c23641e](https://github.com/EIP-GetOut/GETOUT-Platform/commit/c23641ec45848fff053b8f06a1d52b41ea039d4b))
* **app:** :sparkles: Add like and dislike button + New page to change mail ([aa8cdd3](https://github.com/EIP-GetOut/GETOUT-Platform/commit/aa8cdd3e564474382ce2ac0e1c97bd6fef5e3829))
* **app:** :sparkles: add request format for saved and liked movies ([bf2fd37](https://github.com/EIP-GetOut/GETOUT-Platform/commit/bf2fd3731a5b84438d96b14857925bae26b11a46))
* **app:** :sparkles: add scroll for movies page ([c3e0b98](https://github.com/EIP-GetOut/GETOUT-Platform/commit/c3e0b9819be4d30f0427dcc8425de10f4d325dd3))
* **app:** :sparkles: add the final requests for liked and saved movies ([1383afa](https://github.com/EIP-GetOut/GETOUT-Platform/commit/1383afa5aa68e42604a80e13608c8f5f034bb77c))
* **app:** :sparkles: adding simple notification (one every 24h) ([b14c6c8](https://github.com/EIP-GetOut/GETOUT-Platform/commit/b14c6c8980fcb320f0e23c96ace2951daf062a7a))
* **app:** :sparkles: when the app is launch, the login screen appear instead of yourmovies ([a53231b](https://github.com/EIP-GetOut/GETOUT-Platform/commit/a53231bd7d620f7c0867a7d43c7c1cce4412bc59))
* **app:** ⬆️ upgrade dependencies and flutter version ([d5bca9d](https://github.com/EIP-GetOut/GETOUT-Platform/commit/d5bca9ddc67dcc4f761e496c41af95b253f19a2a))
* **backend:** :sparkles: book authors + pictures ([61ab4ad](https://github.com/EIP-GetOut/GETOUT-Platform/commit/61ab4adabff7dc0720a078d04091d11cf121ac87))
* **backend:** :sparkles: cast with pictures ([b8fb40b](https://github.com/EIP-GetOut/GETOUT-Platform/commit/b8fb40bcb16500264177af46f96f096279fd87f9))
* **backend:** :sparkles: liked and disliked books routes ([26be20c](https://github.com/EIP-GetOut/GETOUT-Platform/commit/26be20c988c337ec0bbca1bca83004756b1ce262))
* **backend:** :sparkles: liked movies and disliked movies routes ([cf52ed2](https://github.com/EIP-GetOut/GETOUT-Platform/commit/cf52ed2ed44831c20ffc023d3b5ee6a334047371))
* **backend:** :sparkles: movies recommandations V2 route using python "recommandations" service ([c11c474](https://github.com/EIP-GetOut/GETOUT-Platform/commit/c11c474211cf0d239c59d44acf4f6f5c30083cfb))
* **backend:** :sparkles: preferences, casting and generating routes ([28e7928](https://github.com/EIP-GetOut/GETOUT-Platform/commit/28e7928b899185d0f54580ee14fe8ad73dea7a2b))
* **backend:** :sparkles: watchlist and reading list routes (with GET and POST) ([e8e375f](https://github.com/EIP-GetOut/GETOUT-Platform/commit/e8e375f701aaddc7f9f036881f43a28198bc603f))
* **recommandations:** :sparkles: books are now given back with id ([#32](https://github.com/EIP-GetOut/GETOUT-Platform/issues/32)) ([a7e6ef5](https://github.com/EIP-GetOut/GETOUT-Platform/commit/a7e6ef52480198e4eddcf7ad6772191242822727))


### Bug Fixes

* :bug: Authors name and picturs don t print ([dc41048](https://github.com/EIP-GetOut/GETOUT-Platform/commit/dc410484696423ef6b686154acd09698005ea3ca))
* :bug: Now when the back is not giving an image for the authors i am printing a hite square ([87d672d](https://github.com/EIP-GetOut/GETOUT-Platform/commit/87d672d8f5a6ce9e132315115b240b8386481dd4))
* :bug: reordering the unit tests for restored generate movies / books routes ([3d9cb81](https://github.com/EIP-GetOut/GETOUT-Platform/commit/3d9cb8127f2198a1abb490598e26301e654f74e7))
* **app:** :adhesive_bandage: adapting feature to the merge ([4bc6916](https://github.com/EIP-GetOut/GETOUT-Platform/commit/4bc6916f7590e727e76fcad4c60f135bad862f2b))
* **app:** :bug: adding sceollable to the actors ([bcbaefd](https://github.com/EIP-GetOut/GETOUT-Platform/commit/bcbaefd85ed7329f6d2d8da4bfddb782f33f8294))
* **app:** :bug: authorsPicture casing ([7d29626](https://github.com/EIP-GetOut/GETOUT-Platform/commit/7d2962621969e6f13bcbe7225a7a098b375f6f44))
* **app:** :bug: Null page ([0bf5e40](https://github.com/EIP-GetOut/GETOUT-Platform/commit/0bf5e407257c8171eaa4ef9eeff84549f66b5284))
* **app:** :bug: probleme with name / image of the actors ([5da1d59](https://github.com/EIP-GetOut/GETOUT-Platform/commit/5da1d59726c5cb3420e6d33907d69f7e9ee9705a))
* **app:** :bug: The image of the actors wasn t the good size ([0d8adef](https://github.com/EIP-GetOut/GETOUT-Platform/commit/0d8adef18537e49514c31268ded5a750a64a3627))
* **app:** :bug: the name and the image of the actors wasn t print ([af553ae](https://github.com/EIP-GetOut/GETOUT-Platform/commit/af553aeefa1f6d97dfc90d40682e129c44e4ee0c))
* **app:** :lipstick: update all connection screens UI (login, register, forgot password) ([ec401b6](https://github.com/EIP-GetOut/GETOUT-Platform/commit/ec401b64658de37829ced644116f86b5bb050e32))
* **app:** :twisted_rightwards_arrows: change LoadCirlePage by CircularProgressIndicator widget ([66c2af5](https://github.com/EIP-GetOut/GETOUT-Platform/commit/66c2af5dd8fac137860799cec07ecf2ead6a2e9f))
* **app:** ✏️ fixing typos in header and some class names ([e673ef1](https://github.com/EIP-GetOut/GETOUT-Platform/commit/e673ef13112157f67c5d921c229db08c38c2cf4c))
* **backend:** :bug: compile errors on uuid typing of reset password and send email ([b1ed041](https://github.com/EIP-GetOut/GETOUT-Platform/commit/b1ed041f22387e43fb554dc090677c4f6cb8274e))
* **backend:** adding types/uuid ([2a32706](https://github.com/EIP-GetOut/GETOUT-Platform/commit/2a32706fc53c1f64adb4b854ce64cb49031a6226))


### UI Updates

* **app:** :art: add some const, add constants for the token and cookies, remove print ([4015485](https://github.com/EIP-GetOut/GETOUT-Platform/commit/4015485f685da9c056ebbf277f11e7cf10aba2fa))
* **app:** :art: clean code by removing log and add spaces ([42811c2](https://github.com/EIP-GetOut/GETOUT-Platform/commit/42811c2b4a18b3f47383196d81504d2d51f8884d))
* **app:** :art: remove useless commands and handle duration variable correctly ([f03b547](https://github.com/EIP-GetOut/GETOUT-Platform/commit/f03b547e665603a0611e2e905cf45f14b972dbfe))
* **app:** :lipstick: change the title of movies by a bigger title, and minimize the description and add grey color to text ([14a0c1a](https://github.com/EIP-GetOut/GETOUT-Platform/commit/14a0c1a50e8c6b61e9a63ca8024b2181facbf45d))


### Refactors

* **app:** :art: change http://localhost by rootapipath constant ([02fda29](https://github.com/EIP-GetOut/GETOUT-Platform/commit/02fda2990a8c0940eadce5e9fdfbee75accfb665))
* **backend:** :fire: removed useless documentation of old routes and fixed warnings resulted by previous commit ([d96deb6](https://github.com/EIP-GetOut/GETOUT-Platform/commit/d96deb62377f8b9a0c7eab8c1e807d80b0d24983))
* **backend:** :recycle: restored old generate-movies and generate-books routes for production ready backend ([ba15000](https://github.com/EIP-GetOut/GETOUT-Platform/commit/ba150008ce6153a469d24bf9a78aaad6f52391d1))
* **backend:** :recycle: unit tests, recommend movies / books, get movie / book ([fb0776a](https://github.com/EIP-GetOut/GETOUT-Platform/commit/fb0776a84b0ff92944cf6353343c43ce4e4e3044))
* **backend:** improved new recommend movies route, and implemented new recommend books route ([65d0a4b](https://github.com/EIP-GetOut/GETOUT-Platform/commit/65d0a4b9422d3b4998e58177c98a558484dd260a))

## [0.3.0](https://github.com/EIP-GetOut/GETOUT-Platform/compare/v0.2.8...v0.3.0) (2023-10-25)


### Features

* **app:** :sparkles: Disconnection buton on the setting menu ([0acbb3e](https://github.com/EIP-GetOut/GETOUT-Platform/commit/0acbb3ecdcef806529828050a7624a66ccaa2fb3))
* **backend:** :sparkles: new reset password route, and differentiation with the change password route ([e7412ee](https://github.com/EIP-GetOut/GETOUT-Platform/commit/e7412eef3dc9d23781a5904cc95cf18f8c06a0de))
* **backend:** :sparkles: unit tests and code refacto ([c0b6e77](https://github.com/EIP-GetOut/GETOUT-Platform/commit/c0b6e77a4938451f2863975d2a6530d872760b5f))


### Bug Fixes

* **app:** :rotating_light: ([69f157d](https://github.com/EIP-GetOut/GETOUT-Platform/commit/69f157d069eb19101e0cff63a2a297ea1688fbf0))
* **app:** :rotating_light: Fixing pre-commits errors ([7c37b1e](https://github.com/EIP-GetOut/GETOUT-Platform/commit/7c37b1e8e65f1d0c8642338b9f06f9e659fe778c))
* **backend:** :bug: typing of booksresults ([e3ff137](https://github.com/EIP-GetOut/GETOUT-Platform/commit/e3ff137cdde672ccb956753f72643a6e2f99d54b))
* **backend:** :bug: wrong package-lock.json dependencies ([a1c46a9](https://github.com/EIP-GetOut/GETOUT-Platform/commit/a1c46a991f6b5e38ed97ad8e512dd07d9c59dd6e))


### Refactors

* **app:** :recycle: code of connection part (login, register and forgot password) is refactored ([55e0389](https://github.com/EIP-GetOut/GETOUT-Platform/commit/55e0389d500a5a02a32f03bb9d9fc88688060da2))
* **app:** :recycle: Refactor Forms with block plugins ([cbcd420](https://github.com/EIP-GetOut/GETOUT-Platform/commit/cbcd420fe9b8ea82de2c0ff8e495bb5af0107956))

### [0.2.8](https://github.com/EIP-GetOut/GETOUT-Platform/compare/v0.2.7...v0.2.8) (2023-10-09)


### Features

* **backend:** :sparkles: environment type safety and check of presence of variables ([3f752b9](https://github.com/EIP-GetOut/GETOUT-Platform/commit/3f752b902fadbf54ac080a31d104513c84eb4aad))


### Bug Fixes

* **app:** :wheelchair: when build in release, connection is made with the new back end prod link ([26f314e](https://github.com/EIP-GetOut/GETOUT-Platform/commit/26f314ed81b4cca416a7e4c1a9baab4c40fee21e))
* **CICD:** :sparkles: adapt secret name to be more explicit ([bc14cc0](https://github.com/EIP-GetOut/GETOUT-Platform/commit/bc14cc02743305fc7eea5416eb7d30edee220997))
* **CICD:** :sparkles: can now create release of the apk via github actions ([0a56a45](https://github.com/EIP-GetOut/GETOUT-Platform/commit/0a56a455a5757e9c6248aced802939c2b27a3141))

### [0.2.7](https://github.com/EIP-GetOut/GETOUT-Platform/compare/v0.2.6-test...v0.2.7) (2023-09-27)


### Features

* **backend:** :sparkles: cors enabled and dto middleware ([07e1dcf](https://github.com/EIP-GetOut/GETOUT-Platform/commit/07e1dcf21e3a5161a1762f32e988093a1acc8b9d))
* **backend:** :sparkles: improved linter and unit tests poc ([2924992](https://github.com/EIP-GetOut/GETOUT-Platform/commit/2924992f6f50e1822af2d6b07891804f92ccd44d))
* **backend:** :sparkles: whole new error handling systems for routes using custom error classes ([a56cc3d](https://github.com/EIP-GetOut/GETOUT-Platform/commit/a56cc3d82e754c968164bdb24f34ea1e6a035220))
* **devs/setup_intl_bloc:** :sparkles: setup intl(l10n) and bloc. handle material_app.locale using bloc and l10n ([a657af7](https://github.com/EIP-GetOut/GETOUT-Platform/commit/a657af716309264f6ba97f1f43ba15a52bfc6ea0))


### Bug Fixes

* :memo: move files from 'docs/', to 'doc/' folder ([93f8dfe](https://github.com/EIP-GetOut/GETOUT-Platform/commit/93f8dfe2a24073ff2fe914db1872288ee0add798))
* **backend:** :bug: booksObtained null result check inverted condition ([f4c7f4e](https://github.com/EIP-GetOut/GETOUT-Platform/commit/f4c7f4eca03a8e431845a71480be21c403deea46))


### Refactors

* :recycle: Start to refactor dashbord with implementing bloc, not works yet ([e33bcdf](https://github.com/EIP-GetOut/GETOUT-Platform/commit/e33bcdf7d0ed88633ecb2a3a0fafe29937764bfc))
* **app:** :bricks: :memo: set up the new architecture and adding the new coding style documentation ([a68ca59](https://github.com/EIP-GetOut/GETOUT-Platform/commit/a68ca59bb1c51928ba6178ae57e10dcfb4f6bbef))
* **app:** :recycle: change http request by dio, add blocs for pages movies details ([4a75e5e](https://github.com/EIP-GetOut/GETOUT-Platform/commit/4a75e5e6b7ee0da13bfdbc566b09dab77a9f25d5))
* **app:** :recycle: change loading errors ([8c2910b](https://github.com/EIP-GetOut/GETOUT-Platform/commit/8c2910b7a61bf87cc5fa516f1ceedaf8dbc0d536))
* **app:** :recycle: change movie request with http instead of http package ([5540ed7](https://github.com/EIP-GetOut/GETOUT-Platform/commit/5540ed7eead4a06a2d0d4f329981a277aecd5f8f))
* **app:** :recycle: fix errors due to scaffold and expanded size ([474883b](https://github.com/EIP-GetOut/GETOUT-Platform/commit/474883b1007e69caac5124c8bf5c7e446bdc629b))
* **app:** :recycle: Start to refactor dashboard with implementing bloc, not works yet ([7b703a8](https://github.com/EIP-GetOut/GETOUT-Platform/commit/7b703a83f277f3fab9f223288b59dd922f65c4c5))
* **app:** :recycle: ternary to simple conditional branching, add headers for all files, and sort imports ([88e981f](https://github.com/EIP-GetOut/GETOUT-Platform/commit/88e981f092f7a2f72e6cd9a9afa3dad211247e0f))
* **app:** :recycle: transform book part with bloc package and change genres generate with random by those selected in forms ([a69878f](https://github.com/EIP-GetOut/GETOUT-Platform/commit/a69878ff29af56aed79c23900b202c77c671669b))
* **CICD:** :truck: properly renamed github actions ([7a7ba38](https://github.com/EIP-GetOut/GETOUT-Platform/commit/7a7ba38829690878d59210c474904b65f4d4ddb4))

### [0.2.6-test](https://github.com/EIP-GetOut/GETOUT-Platform/compare/v0.2.5-test...v0.2.6-test) (2023-06-29)

### [0.2.4](https://github.com/EIP-GetOut/GETOUT-Platform/compare/v0.2.3...v0.2.4) (2023-06-29)

### [0.2.3](https://github.com/EIP-GetOut/GETOUT-Platform/compare/v0.2.2...v0.2.3) (2023-06-29)

### [0.2.1](https://github.com/EIP-GetOut/GETOUT-Platform/compare/v0.2.0...v0.2.1) (2023-06-29)

### [0.2.1](https://github.com/EIP-GetOut/GETOUT-Platform/compare/v0.1.15...v0.2.1) (2023-06-29)


### Features

* **backend:** :memo: generate a documentation ([5a18e4c](https://github.com/EIP-GetOut/GETOUT-Platform/commit/5a18e4c3b0a11fb2c399248b0ec1dd7c6e09607c))


### Bug Fixes

* **backend:** :adhesive_bandage: removing console.log ([4c530bd](https://github.com/EIP-GetOut/GETOUT-Platform/commit/4c530bd4f7d5dca860dc47f5e3247346420e7925))

## 0.2.0 (2023-06-28)

### Features

* **app:** :art: code of form pages is now in english and have no more warning ([5c2c268](https://github.com/EIP-GetOut/GETOUT-Platform/commit/5c2c268e7cc8e88c6c5d84fc1f9da024c39be05e))
* **app:** :art: home and preference pages are now in layouts/ and add a debug button in a home to go in the playground ([68893e5](https://github.com/EIP-GetOut/GETOUT-Platform/commit/68893e5879f014bf28cafd3cdd77a08eacd57d8c))
* **app:** :art: improve code for almost all files ([c39e98d](https://github.com/EIP-GetOut/GETOUT-Platform/commit/c39e98ddd27bd59c073d22ae641774adb46807bb))
* **app:** :art: improve code for the checkBoxList for the preference page ([b75e29e](https://github.com/EIP-GetOut/GETOUT-Platform/commit/b75e29ea4e6f479ff08c8eaf1e6f0c730e74a5dd))
* **app:** :art: loading page is now only a page that display a load logo (no more redirection from it) ([2f29723](https://github.com/EIP-GetOut/GETOUT-Platform/commit/2f297236e376b4e16b2b70f9b6122068ac4f8fe4))
* **app:** :art: register have now clean loading page and errors from back-end are now handled ([f3e072d](https://github.com/EIP-GetOut/GETOUT-Platform/commit/f3e072dbe1ca3d0f18c971f5ae2efcfec37eee90))
* **app:** :bento: adding new photo and new images for the new home page ([330a341](https://github.com/EIP-GetOut/GETOUT-Platform/commit/330a341db88a19cc76cafcd56cb044b47d000bed))
* **app:** :construction: Seekbar is updating when clickevent ([d34a708](https://github.com/EIP-GetOut/GETOUT-Platform/commit/d34a708a468489764dc6b76344dd03a6849ea7e6))
* **app:** :heavy_plus_sign: add google font dependencices ([ecc04c3](https://github.com/EIP-GetOut/GETOUT-Platform/commit/ecc04c3f2eec09cd71803ad789b4b885fd5f87f7))
* **app:** :lipstick: add a real home page (like the figma one) ([ac3725c](https://github.com/EIP-GetOut/GETOUT-Platform/commit/ac3725c23423bca87f175f4fed87ffaea5cc4004))
* **app:** :lipstick: add compatibility to landscape for home page and slider page ([fc904a7](https://github.com/EIP-GetOut/GETOUT-Platform/commit/fc904a71c1d6655cffc7f9ecb24f85b0d299637b))
* **app:** :lipstick: Add seekbar using a ViewPage with both in horizontaly axis ([959607e](https://github.com/EIP-GetOut/GETOUT-Platform/commit/959607e17c0d13a654d32e7fa308fb7b45d158ff))
* **app:** :lipstick: adding the font (applied on almost all text) ([3bb4f80](https://github.com/EIP-GetOut/GETOUT-Platform/commit/3bb4f80bea2edcdb3d739c1fe34ecafd7d9fcde0))
* **app:** :lipstick: adding the font (applied on almost all text) ([3850736](https://github.com/EIP-GetOut/GETOUT-Platform/commit/385073697de970688feedd92b2d2eec21aaf0521))
* **app:** :lipstick: beautiful loading page ([54849f9](https://github.com/EIP-GetOut/GETOUT-Platform/commit/54849f920b6ef664de2e32e571bd54caf17ae78c))
* **app:** :lipstick: edit Dashboard style & add sharedPreference test. ([26a1fd2](https://github.com/EIP-GetOut/GETOUT-Platform/commit/26a1fd2c1f6432785b0180e6070a84c9e0c97ded))
* **app:** :lipstick: film now have now synopsis in their details and the home page is prettier ([78e85ae](https://github.com/EIP-GetOut/GETOUT-Platform/commit/78e85ae9eb7e6af9830c0e7a8177859df8315fbd))
* **app:** :poop: basic flutter app with playground ([5615060](https://github.com/EIP-GetOut/GETOUT-Platform/commit/5615060f3478c214de9afce97aa5a87285e34baa))
* **app:** :poop: regroup layout pref in one main page ([46b05fb](https://github.com/EIP-GetOut/GETOUT-Platform/commit/46b05fb2813c617883a379391842e5c7c7332f6f))
* **app:** :sparkles: add a new "next" button on preference page (for the moment, redirect to home page) ([89ac94e](https://github.com/EIP-GetOut/GETOUT-Platform/commit/89ac94e75a1b9a18ce2b799e2e6cd2fbd1327df9))
* **app:** :sparkles: add first connection button and separation ([75c2ffc](https://github.com/EIP-GetOut/GETOUT-Platform/commit/75c2ffc488d234dc485e1ba7ea0485e681335502))
* **app:** :sparkles: add header and change date picker language ([b98c273](https://github.com/EIP-GetOut/GETOUT-Platform/commit/b98c273ab6c8247e4cb211b9304c8d9645aa250c))
* **app:** :sparkles: add movie details ([d74e46f](https://github.com/EIP-GetOut/GETOUT-Platform/commit/d74e46f95ff516da1fa91d6938e592a4b15a853d))
* **app:** :sparkles: add new field and date picker with handling error ([b1ecfcb](https://github.com/EIP-GetOut/GETOUT-Platform/commit/b1ecfcb83286d35df4d28e1f9789ab84332cb1d9))
* **app:** :sparkles: add onBackPressed => edit PageView index ([3dcab7e](https://github.com/EIP-GetOut/GETOUT-Platform/commit/3dcab7e6155430b0538a9fa1fff8bf39230f4151))
* **app:** :sparkles: add real slider(widget) for preferences->hours spend ([afe2c18](https://github.com/EIP-GetOut/GETOUT-Platform/commit/afe2c18f3776db590dadbcc4c46e2469a2e78f7b))
* **app:** :sparkles: adding register page with 2 passwords (they need to be the same to work) with 8 char minimum and a valid mail ([776ec56](https://github.com/EIP-GetOut/GETOUT-Platform/commit/776ec56097adebe5e19b7e0cc001b6cbc43594ed))
* **app:** :sparkles: change logo, for the app and when we launch it ([7d78ab2](https://github.com/EIP-GetOut/GETOUT-Platform/commit/7d78ab2138a5c6b4a7bc7a5490fc983058ac0165))
* **app:** :sparkles: connection between back end and mobile is set for sign up (error message are not set yet) ([3266e45](https://github.com/EIP-GetOut/GETOUT-Platform/commit/3266e45dedc341b429480466c5ec9db8cbb85095))
* **app:** :sparkles: create requests for create an account ([1c1ede2](https://github.com/EIP-GetOut/GETOUT-Platform/commit/1c1ede2536f597c4bb37c0cc60a51da176188028))
* **app:** :sparkles: display books on the dashboard ([2d7b52d](https://github.com/EIP-GetOut/GETOUT-Platform/commit/2d7b52d201ff18d53bd8c26c4eed8ac5357d673b))
* **app:** :sparkles: handling status code for login and start movie page ([511e6b9](https://github.com/EIP-GetOut/GETOUT-Platform/commit/511e6b9c39408033d8e18ac0d908ae42c03f20a7))
* **app:** :sparkles: home->welcome & add Home/(LoadingPage & dashboardPage) ([b85bae9](https://github.com/EIP-GetOut/GETOUT-Platform/commit/b85bae99713e75e4fad148e772896f7a93aa0798))
* **app:** :sparkles: know detect release and debug mode and adapt to it ([fcaa62c](https://github.com/EIP-GetOut/GETOUT-Platform/commit/fcaa62ca90f0d03dc6bbd9d5e2d383ac2f3d9ecc))
* **app:** :sparkles: link backend to frontend for login step ([ba223f1](https://github.com/EIP-GetOut/GETOUT-Platform/commit/ba223f1ab7594e46c0b1974df3dc5b244c9ce980))
* **app:** :sparkles: LoadingPage redirect to DashboardPage, with 5 random movies load and send from loadingPage. ([2a5568c](https://github.com/EIP-GetOut/GETOUT-Platform/commit/2a5568c06f8f15d453f7d88875738ebd3e287c6e))
* **app:** :sparkles: LoadingPage redirect to DashboardPage, with 5 random movies load and send from loadingPage. ([0545691](https://github.com/EIP-GetOut/GETOUT-Platform/commit/05456917add0f3533b22709f62afc1e5b6f23894))
* **app:** :sparkles: login now need all field complete with a valid mail and a password ([fd34945](https://github.com/EIP-GetOut/GETOUT-Platform/commit/fd34945790b85e48fd4b46d532208c59f1ebc2eb))
* **app:** :sparkles: overview are now set with a max line ([099f2c8](https://github.com/EIP-GetOut/GETOUT-Platform/commit/099f2c8354c3da73e9d8ddd1dd2f750877cc7501))
* **app:** :sparkles: password is now valid if there is 12 char, a upper/lowercase and a number ([7970fda](https://github.com/EIP-GetOut/GETOUT-Platform/commit/7970fda517181a7d407392d7901bd8afc70f488e))
* **app:** :sparkles: Preference scroll and next have been replaced by prev and next button ([fc5ac6e](https://github.com/EIP-GetOut/GETOUT-Platform/commit/fc5ac6e8120784d9a90dd98a209cd47d0fcc2647))
* **app:** :sparkles: questionnary ([c9947e8](https://github.com/EIP-GetOut/GETOUT-Platform/commit/c9947e8a7e27a081d6028a1a3cbb8e8a5c737611))
* **app:** :sparkles: random generate moovie if there is no preferences ([3c88df2](https://github.com/EIP-GetOut/GETOUT-Platform/commit/3c88df20bac65ad7f38b1c7e9b85efb0ec85bd13))
* **app:** :sparkles: redirection to dashboard and add details movie page ([eb276ed](https://github.com/EIP-GetOut/GETOUT-Platform/commit/eb276ede15cb50503f2e3d2fe693788bb5d21a4f))
* **app:** :sparkles: request service with first route to generate movies with proper models and test of it ([5d4e835](https://github.com/EIP-GetOut/GETOUT-Platform/commit/5d4e83586eaf0aae289e9ede3fff16f6f10f4987))
* **app:** :sparkles: sent the good genre for films ([d908f82](https://github.com/EIP-GetOut/GETOUT-Platform/commit/d908f82101c79d438e759acf2dc2518b1ba7d5b3))
* **app:** :sparkles: Theme for all the project with colors / text / button ([203c6ce](https://github.com/EIP-GetOut/GETOUT-Platform/commit/203c6cea2ca362d3b28429a596e6b9b79dd46e2b))
* **app:** :tada: hello world flutter app ([2714a46](https://github.com/EIP-GetOut/GETOUT-Platform/commit/2714a46d4047c21df73783848fb710a0d94b236a))
* **app:** :wrench: add Get Out logo for all os (macOS, Windows, IOS, Android, etc) ([c198c23](https://github.com/EIP-GetOut/GETOUT-Platform/commit/c198c2365b1365243538906ccbb3aeae8baff051))
* **app:** 🎨 adding new items in the theme and apllying it in the code ([87eb1ee](https://github.com/EIP-GetOut/GETOUT-Platform/commit/87eb1ee8e5f4c400514db01c4cfa65f97d43cc7a))
* **app:** 🎨 adding new items in the theme and apllying it in the code ([f226a8e](https://github.com/EIP-GetOut/GETOUT-Platform/commit/f226a8e38304d19ec88e42fb87c9d56f9bc8b205))
* **app:** 🎨 adjuste the color of the end page ([4bbeb01](https://github.com/EIP-GetOut/GETOUT-Platform/commit/4bbeb0177af2c34be69f28b4148063fbb7ae684f))
* **app:** 🎨 change the active color of the CheckBox to the primaryColor ([ee24da6](https://github.com/EIP-GetOut/GETOUT-Platform/commit/ee24da618926b3839bdb1a9e185ef0df704b22ff))
* **app:** 🎨 change the last logo in the last questionnary ([00826b6](https://github.com/EIP-GetOut/GETOUT-Platform/commit/00826b67e1ad48f4346b27d2acacf97783a03bbe))
* **backend:** :memo: generate a documentation ([5a18e4c](https://github.com/EIP-GetOut/GETOUT-Platform/commit/5a18e4c3b0a11fb2c399248b0ec1dd7c6e09607c))
* **backend:** :sparkles: adding security on passwords ([5b8580a](https://github.com/EIP-GetOut/GETOUT-Platform/commit/5b8580a94ccc91dd2e0707feb5e2375dd997ecc6))
* **backend:** :sparkles: basic reset-password route ([a96d765](https://github.com/EIP-GetOut/GETOUT-Platform/commit/a96d76531900233506ad23f30adee66894209bff))
* **backend:** :sparkles: changing return value ([6886082](https://github.com/EIP-GetOut/GETOUT-Platform/commit/6886082827c140f504e87f33a61b46b5e018e042))
* **backend:** :sparkles: changing the return value ([28fb793](https://github.com/EIP-GetOut/GETOUT-Platform/commit/28fb7937b8922f745b84438377b139478398af50))
* **backend:** :sparkles: filter returned data by generate routes ([948c2ce](https://github.com/EIP-GetOut/GETOUT-Platform/commit/948c2cee1c95ca7dba380e8f4e542537461982c5))
* **backend:** :sparkles: get details of one book with it UUID ([79c9b86](https://github.com/EIP-GetOut/GETOUT-Platform/commit/79c9b8678b4e8d64ccb791369f7b7ae99e10d892))
* **backend:** :sparkles: getDetail from an id(film) ([523ea8e](https://github.com/EIP-GetOut/GETOUT-Platform/commit/523ea8e7c772a69b7b2ed2dce79aa783df4d3bdd))
* **backend:** :sparkles: getting 5 books with criteria ([aa05dae](https://github.com/EIP-GetOut/GETOUT-Platform/commit/aa05dae8d3c341d526f55fc6034368f9cccecb6f))
* **backend:** :sparkles: Getting 5 movies with criteria ([c5769dc](https://github.com/EIP-GetOut/GETOUT-Platform/commit/c5769dcb5d532128fec619fe62c66d1a4cfa4d17))
* **backend:** :sparkles: introducing the database ([6709d4b](https://github.com/EIP-GetOut/GETOUT-Platform/commit/6709d4bb9595b778b241f79f55c42144cd041e64))
* **backend:** :sparkles: login and signup ([2159037](https://github.com/EIP-GetOut/GETOUT-Platform/commit/2159037496958cf38c7c9516c04befb2b62ac514))
* **backend:** :sparkles: oauth route ([d7ddc01](https://github.com/EIP-GetOut/GETOUT-Platform/commit/d7ddc01865b438bde400742c6f3f74b2c997616a))
* **backend:** :sparkles: sessions handling with logout route and session route 1wk duration ([aad4899](https://github.com/EIP-GetOut/GETOUT-Platform/commit/aad4899bee65f48341dd45d0af54aee50137dd0e))
* **backend:** :tada: fresh express backend with root endpoints ([6ae996d](https://github.com/EIP-GetOut/GETOUT-Platform/commit/6ae996d7854fafa19f4c36f97fdb2ad6329c206b))
* **CICD:** :sparkles: add a GA to deploy when pushed on prod ([74a90be](https://github.com/EIP-GetOut/GETOUT-Platform/commit/74a90bec413cc08ea37704aa8fcbcbceece3223d))
* **CICD:** :sparkles: add github actions to check linter ([16ce747](https://github.com/EIP-GetOut/GETOUT-Platform/commit/16ce747ccfc5ea7c865b5012cc11f59e2c99a2d6))
* **connection:** :sparkles: add connection page with basic email and password ([a5f380a](https://github.com/EIP-GetOut/GETOUT-Platform/commit/a5f380aef0f3ac7cadd85c6455b6ea43d1f89a73))
* **connection:** add logo of services ([4c0a91a](https://github.com/EIP-GetOut/GETOUT-Platform/commit/4c0a91a1027e92bed0018f8052ac048225feeb12))
* **dev-oauth:** :sparkles: add (dev)google-oauth2 ([5962794](https://github.com/EIP-GetOut/GETOUT-Platform/commit/596279488aadca4ce440e59e17061852e28c2710))
* **dev:** :sparkles: :beers: settings/edit-password(request not made during process need to be fix) ([321f74b](https://github.com/EIP-GetOut/GETOUT-Platform/commit/321f74b08bac2c5fedd2ac1f370876c8b3c2bebe))
* **dev:** :sparkles: add forgetPasswordCode/Change ([a056ee3](https://github.com/EIP-GetOut/GETOUT-Platform/commit/a056ee3a8d7d81d81134af298dda67b823961980))
* **dev:** :sparkles: oauth request ([31a332b](https://github.com/EIP-GetOut/GETOUT-Platform/commit/31a332b812ff980a9beddd3a3b822d8277b64b48))


### Bug Fixes

* :bug: getSession when user logged in ([87ea723](https://github.com/EIP-GetOut/GETOUT-Platform/commit/87ea72364bff420a9c919f285c7482b73b7b25f0))
* **add mykey.jks:** :technologist: ([6ae7497](https://github.com/EIP-GetOut/GETOUT-Platform/commit/6ae74975b2f639f633f3b2e056a514aa1106faaf))
* **app:** :adhesive_bandage: getSession is now called only once when the app is launched and no longer block input ([c433a96](https://github.com/EIP-GetOut/GETOUT-Platform/commit/c433a96dcddaf4aa6b6d39ba54efa4081b4b6f96))
* **app:** :art: center up the connection page ([fb5803d](https://github.com/EIP-GetOut/GETOUT-Platform/commit/fb5803d523ec38cb531bf18eb02104e83741d21d))
* **app:** :art: put right path for the api in release mode ([968370e](https://github.com/EIP-GetOut/GETOUT-Platform/commit/968370eb5caca72a798b9a657664574185e8bec8))
* **app:** :bug: :art: register validators are working again (by fixing it, there was a code structure improvement) ([77ba006](https://github.com/EIP-GetOut/GETOUT-Platform/commit/77ba006fe92e444f846c8bc3275aef6a442b3133))
* **app:** :bug: if the film duration is 0h0min, display "N/A", same thing if synopsis is empty ([8005a63](https://github.com/EIP-GetOut/GETOUT-Platform/commit/8005a6382c426f88354d4873b41629655d0c8077))
* **app:** :bug: if the film duration is 0h0min, display "N/A", same thing if synopsis is empty ([3bbfb4b](https://github.com/EIP-GetOut/GETOUT-Platform/commit/3bbfb4bd328b8014b5d243431fb58c0b041892d3))
* **app:** :bug: sometimes some overviews are null ([a0ced75](https://github.com/EIP-GetOut/GETOUT-Platform/commit/a0ced75599b0780a8fc63aff8e39e9f5c69ab249))
* **app:** :bug: wrong path for release api path ([b1d4e39](https://github.com/EIP-GetOut/GETOUT-Platform/commit/b1d4e39d64f78e73226d3eb7693740e992965d73))
* **app:** :lipstick: Size of button and color of the slider ([a37b19a](https://github.com/EIP-GetOut/GETOUT-Platform/commit/a37b19aecda984165245d21796ece34ddcf3d40b))
* **app:** :pencil2: pages and widgets directory are now in lower case ([ed539ee](https://github.com/EIP-GetOut/GETOUT-Platform/commit/ed539ee294b3f9545a344d2fb37b7e9194cd48be))
* **app:** :rotating_light: fix warnings ([86f6be3](https://github.com/EIP-GetOut/GETOUT-Platform/commit/86f6be3c0ac4bdb99059de0031cdef73d67e4e92))
* **app:** :sparkles: call request for login ([b7d0048](https://github.com/EIP-GetOut/GETOUT-Platform/commit/b7d0048c509f66ea8353a3889e5ccb6c2a38457d))
* **app:** :sparkles: connection between back and front for login ([0c633b9](https://github.com/EIP-GetOut/GETOUT-Platform/commit/0c633b91232010e8f6d4e788308c85b59d37ace3))
* **backend:** :adhesive_bandage: changing the value of the time returned ([ecdb599](https://github.com/EIP-GetOut/GETOUT-Platform/commit/ecdb599d6f267258f123bed03709e90cb88a0f91))
* **backend:** :adhesive_bandage: error code in login and typo in register ([a84ed61](https://github.com/EIP-GetOut/GETOUT-Platform/commit/a84ed61a35e2cc424514287217f7866ccc405148))
* **backend:** :adhesive_bandage: path to entities ([c54e880](https://github.com/EIP-GetOut/GETOUT-Platform/commit/c54e880a17efbf66afbdc0dc33e268ce2f370001))
* **backend:** :adhesive_bandage: removing console.log ([4c530bd](https://github.com/EIP-GetOut/GETOUT-Platform/commit/4c530bd4f7d5dca860dc47f5e3247346420e7925))
* **backend:** :bug: get 5 books and get the details of a single book ([7258cb7](https://github.com/EIP-GetOut/GETOUT-Platform/commit/7258cb7edb62102eeff905c38d31c12a80df578e))
* **backend:** :bug: getMovies parseInt on nullable page parameter ([a1ec937](https://github.com/EIP-GetOut/GETOUT-Platform/commit/a1ec93792645862537b572455af67d9f0a1b5a85))
* **backend:** :bug: resetPassword, package.json module, tests .rests ([c4d105f](https://github.com/EIP-GetOut/GETOUT-Platform/commit/c4d105fd76e90d9c3482a80b1910869445134671))
* **backend:** :building_construction: changing the interface ([851c015](https://github.com/EIP-GetOut/GETOUT-Platform/commit/851c01582108af559b5046aadc8bd633070d28cf))
* **backend:** :rotating_light: adding context to the docker-compose ([7a74603](https://github.com/EIP-GetOut/GETOUT-Platform/commit/7a7460399bcd2a19ae3fe9108f91501e95f8936d))
* **backend:** :truck: using params instead of query ([619b874](https://github.com/EIP-GetOut/GETOUT-Platform/commit/619b874231b175a6f50a791009bc04fc335df9d9))
* **backend:** error in header ([70bddbe](https://github.com/EIP-GetOut/GETOUT-Platform/commit/70bddbe2111bc851ab258a4d79067ed0b73643e1))
* **CICD:** :green_heart: fix ga working with node 16 ([26ac288](https://github.com/EIP-GetOut/GETOUT-Platform/commit/26ac28873fe03e8dcc0577d78c97eac9033b92f4))
* **CICD:** :sparkles: fix job script name ([a220d1c](https://github.com/EIP-GetOut/GETOUT-Platform/commit/a220d1c1a317267ecfd12f4f515340bbc91d41d8))
* **CICD:** fill app release.apk filename ([d8cb46a](https://github.com/EIP-GetOut/GETOUT-Platform/commit/d8cb46a499a2fd97c576b3bb9eb6b43dd0810f13))
* **dev:** :art: fix flutter analyze ([cc075ce](https://github.com/EIP-GetOut/GETOUT-Platform/commit/cc075ce1cee3c22b48bcc5060a0985ca1cdcf121))
* **dev:** :bug: fix \'flutter analyze\' ([b93a4c2](https://github.com/EIP-GetOut/GETOUT-Platform/commit/b93a4c27e176afb1d80dc7bff8aa65fabfe5e920))
* **dev:** :bug: fix apiRoot & print Info ([6335ebf](https://github.com/EIP-GetOut/GETOUT-Platform/commit/6335ebfd71a2167ee3a58e8b2fcb87953d4b616b))
* **dev:** :bug: fix rootApitPath ([790a02b](https://github.com/EIP-GetOut/GETOUT-Platform/commit/790a02b3fe2bb1146a963a7e9aac915fd2f4c070))
* **dev:** :bug: I forget rootApi ([b702cb4](https://github.com/EIP-GetOut/GETOUT-Platform/commit/b702cb4951648473d046244228a9faad0d48d3eb))
* **dev:** :memo: fix title value ([58e191b](https://github.com/EIP-GetOut/GETOUT-Platform/commit/58e191bec295b93ac39084404608e6135dbde02e))

## 0.1.0 (2023-06-19)


### Features

* **app:** :art: home and preference pages are now in layouts/ and add a debug button in a home to go in the playground ([68893e5](https://github.com/EIP-GetOut/GETOUT-Platform/commit/68893e5879f014bf28cafd3cdd77a08eacd57d8c))
* **app:** :art: improve code for almost all files ([c39e98d](https://github.com/EIP-GetOut/GETOUT-Platform/commit/c39e98ddd27bd59c073d22ae641774adb46807bb))
* **app:** :art: improve code for the checkBoxList for the preference page ([b75e29e](https://github.com/EIP-GetOut/GETOUT-Platform/commit/b75e29ea4e6f479ff08c8eaf1e6f0c730e74a5dd))
* **app:** :art: loading page is now only a page that display a load logo (no more redirection from it) ([2f29723](https://github.com/EIP-GetOut/GETOUT-Platform/commit/2f297236e376b4e16b2b70f9b6122068ac4f8fe4))
* **app:** :art: register have now clean loading page and errors from back-end are now handled ([f3e072d](https://github.com/EIP-GetOut/GETOUT-Platform/commit/f3e072dbe1ca3d0f18c971f5ae2efcfec37eee90))
* **app:** :construction: Seekbar is updating when clickevent ([d34a708](https://github.com/EIP-GetOut/GETOUT-Platform/commit/d34a708a468489764dc6b76344dd03a6849ea7e6))
* **app:** :heavy_plus_sign: add google font dependencices ([ecc04c3](https://github.com/EIP-GetOut/GETOUT-Platform/commit/ecc04c3f2eec09cd71803ad789b4b885fd5f87f7))
* **app:** :lipstick: add a real home page (like the figma one) ([ac3725c](https://github.com/EIP-GetOut/GETOUT-Platform/commit/ac3725c23423bca87f175f4fed87ffaea5cc4004))
* **app:** :lipstick: add compatibility to landscape for home page and slider page ([fc904a7](https://github.com/EIP-GetOut/GETOUT-Platform/commit/fc904a71c1d6655cffc7f9ecb24f85b0d299637b))
* **app:** :lipstick: Add seekbar using a ViewPage with both in horizontaly axis ([959607e](https://github.com/EIP-GetOut/GETOUT-Platform/commit/959607e17c0d13a654d32e7fa308fb7b45d158ff))
* **app:** :lipstick: adding the font (applied on almost all text) ([3bb4f80](https://github.com/EIP-GetOut/GETOUT-Platform/commit/3bb4f80bea2edcdb3d739c1fe34ecafd7d9fcde0))
* **app:** :lipstick: adding the font (applied on almost all text) ([3850736](https://github.com/EIP-GetOut/GETOUT-Platform/commit/385073697de970688feedd92b2d2eec21aaf0521))
* **app:** :lipstick: beautiful loading page ([54849f9](https://github.com/EIP-GetOut/GETOUT-Platform/commit/54849f920b6ef664de2e32e571bd54caf17ae78c))
* **app:** :lipstick: edit Dashboard style & add sharedPreference test. ([26a1fd2](https://github.com/EIP-GetOut/GETOUT-Platform/commit/26a1fd2c1f6432785b0180e6070a84c9e0c97ded))
* **app:** :poop: basic flutter app with playground ([5615060](https://github.com/EIP-GetOut/GETOUT-Platform/commit/5615060f3478c214de9afce97aa5a87285e34baa))
* **app:** :poop: regroup layout pref in one main page ([46b05fb](https://github.com/EIP-GetOut/GETOUT-Platform/commit/46b05fb2813c617883a379391842e5c7c7332f6f))
* **app:** :sparkles: add a new "next" button on preference page (for the moment, redirect to home page) ([89ac94e](https://github.com/EIP-GetOut/GETOUT-Platform/commit/89ac94e75a1b9a18ce2b799e2e6cd2fbd1327df9))
* **app:** :sparkles: add first connection button and separation ([75c2ffc](https://github.com/EIP-GetOut/GETOUT-Platform/commit/75c2ffc488d234dc485e1ba7ea0485e681335502))
* **app:** :sparkles: add header and change date picker language ([b98c273](https://github.com/EIP-GetOut/GETOUT-Platform/commit/b98c273ab6c8247e4cb211b9304c8d9645aa250c))
* **app:** :sparkles: add movie details ([d74e46f](https://github.com/EIP-GetOut/GETOUT-Platform/commit/d74e46f95ff516da1fa91d6938e592a4b15a853d))
* **app:** :sparkles: add new field and date picker with handling error ([b1ecfcb](https://github.com/EIP-GetOut/GETOUT-Platform/commit/b1ecfcb83286d35df4d28e1f9789ab84332cb1d9))
* **app:** :sparkles: add onBackPressed => edit PageView index ([3dcab7e](https://github.com/EIP-GetOut/GETOUT-Platform/commit/3dcab7e6155430b0538a9fa1fff8bf39230f4151))
* **app:** :sparkles: add real slider(widget) for preferences->hours spend ([afe2c18](https://github.com/EIP-GetOut/GETOUT-Platform/commit/afe2c18f3776db590dadbcc4c46e2469a2e78f7b))
* **app:** :sparkles: adding register page with 2 passwords (they need to be the same to work) with 8 char minimum and a valid mail ([776ec56](https://github.com/EIP-GetOut/GETOUT-Platform/commit/776ec56097adebe5e19b7e0cc001b6cbc43594ed))
* **app:** :sparkles: change logo, for the app and when we launch it ([7d78ab2](https://github.com/EIP-GetOut/GETOUT-Platform/commit/7d78ab2138a5c6b4a7bc7a5490fc983058ac0165))
* **app:** :sparkles: connection between back end and mobile is set for sign up (error message are not set yet) ([3266e45](https://github.com/EIP-GetOut/GETOUT-Platform/commit/3266e45dedc341b429480466c5ec9db8cbb85095))
* **app:** :sparkles: create requests for create an account ([1c1ede2](https://github.com/EIP-GetOut/GETOUT-Platform/commit/1c1ede2536f597c4bb37c0cc60a51da176188028))
* **app:** :sparkles: handling status code for login and start movie page ([511e6b9](https://github.com/EIP-GetOut/GETOUT-Platform/commit/511e6b9c39408033d8e18ac0d908ae42c03f20a7))
* **app:** :sparkles: home->welcome & add Home/(LoadingPage & dashboardPage) ([b85bae9](https://github.com/EIP-GetOut/GETOUT-Platform/commit/b85bae99713e75e4fad148e772896f7a93aa0798))
* **app:** :sparkles: link backend to frontend for login step ([ba223f1](https://github.com/EIP-GetOut/GETOUT-Platform/commit/ba223f1ab7594e46c0b1974df3dc5b244c9ce980))
* **app:** :sparkles: LoadingPage redirect to DashboardPage, with 5 random movies load and send from loadingPage. ([2a5568c](https://github.com/EIP-GetOut/GETOUT-Platform/commit/2a5568c06f8f15d453f7d88875738ebd3e287c6e))
* **app:** :sparkles: LoadingPage redirect to DashboardPage, with 5 random movies load and send from loadingPage. ([0545691](https://github.com/EIP-GetOut/GETOUT-Platform/commit/05456917add0f3533b22709f62afc1e5b6f23894))
* **app:** :sparkles: login now need all field complete with a valid mail and a password ([fd34945](https://github.com/EIP-GetOut/GETOUT-Platform/commit/fd34945790b85e48fd4b46d532208c59f1ebc2eb))
* **app:** :sparkles: password is now valid if there is 12 char, a upper/lowercase and a number ([7970fda](https://github.com/EIP-GetOut/GETOUT-Platform/commit/7970fda517181a7d407392d7901bd8afc70f488e))
* **app:** :sparkles: Preference scroll and next have been replaced by prev and next button ([fc5ac6e](https://github.com/EIP-GetOut/GETOUT-Platform/commit/fc5ac6e8120784d9a90dd98a209cd47d0fcc2647))
* **app:** :sparkles: redirection to dashboard and add details movie page ([eb276ed](https://github.com/EIP-GetOut/GETOUT-Platform/commit/eb276ede15cb50503f2e3d2fe693788bb5d21a4f))
* **app:** :sparkles: request service with first route to generate movies with proper models and test of it ([5d4e835](https://github.com/EIP-GetOut/GETOUT-Platform/commit/5d4e83586eaf0aae289e9ede3fff16f6f10f4987))
* **app:** :sparkles: Theme for all the project with colors / text / button ([203c6ce](https://github.com/EIP-GetOut/GETOUT-Platform/commit/203c6cea2ca362d3b28429a596e6b9b79dd46e2b))
* **app:** :tada: hello world flutter app ([2714a46](https://github.com/EIP-GetOut/GETOUT-Platform/commit/2714a46d4047c21df73783848fb710a0d94b236a))
* **app:** :wrench: add Get Out logo for all os (macOS, Windows, IOS, Android, etc) ([c198c23](https://github.com/EIP-GetOut/GETOUT-Platform/commit/c198c2365b1365243538906ccbb3aeae8baff051))
* **backend:** :sparkles: basic reset-password route ([a96d765](https://github.com/EIP-GetOut/GETOUT-Platform/commit/a96d76531900233506ad23f30adee66894209bff))
* **backend:** :sparkles: filter returned data by generate routes ([948c2ce](https://github.com/EIP-GetOut/GETOUT-Platform/commit/948c2cee1c95ca7dba380e8f4e542537461982c5))
* **backend:** :sparkles: get details of one book with it UUID ([79c9b86](https://github.com/EIP-GetOut/GETOUT-Platform/commit/79c9b8678b4e8d64ccb791369f7b7ae99e10d892))
* **backend:** :sparkles: getDetail from an id(film) ([523ea8e](https://github.com/EIP-GetOut/GETOUT-Platform/commit/523ea8e7c772a69b7b2ed2dce79aa783df4d3bdd))
* **backend:** :sparkles: getting 5 books with criteria ([aa05dae](https://github.com/EIP-GetOut/GETOUT-Platform/commit/aa05dae8d3c341d526f55fc6034368f9cccecb6f))
* **backend:** :sparkles: Getting 5 movies with criteria ([c5769dc](https://github.com/EIP-GetOut/GETOUT-Platform/commit/c5769dcb5d532128fec619fe62c66d1a4cfa4d17))
* **backend:** :sparkles: introducing the database ([6709d4b](https://github.com/EIP-GetOut/GETOUT-Platform/commit/6709d4bb9595b778b241f79f55c42144cd041e64))
* **backend:** :sparkles: login and signup ([2159037](https://github.com/EIP-GetOut/GETOUT-Platform/commit/2159037496958cf38c7c9516c04befb2b62ac514))
* **backend:** :sparkles: sessions handling with logout route and session route 1wk duration ([aad4899](https://github.com/EIP-GetOut/GETOUT-Platform/commit/aad4899bee65f48341dd45d0af54aee50137dd0e))
* **backend:** :tada: fresh express backend with root endpoints ([6ae996d](https://github.com/EIP-GetOut/GETOUT-Platform/commit/6ae996d7854fafa19f4c36f97fdb2ad6329c206b))
* **CICD:** :sparkles: add a GA to deploy when pushed on prod ([74a90be](https://github.com/EIP-GetOut/GETOUT-Platform/commit/74a90bec413cc08ea37704aa8fcbcbceece3223d))
* **connection:** :sparkles: add connection page with basic email and password ([a5f380a](https://github.com/EIP-GetOut/GETOUT-Platform/commit/a5f380aef0f3ac7cadd85c6455b6ea43d1f89a73))
* **connection:** add logo of services ([4c0a91a](https://github.com/EIP-GetOut/GETOUT-Platform/commit/4c0a91a1027e92bed0018f8052ac048225feeb12))
* **dev-oauth:** :sparkles: add (dev)google-oauth2 ([5962794](https://github.com/EIP-GetOut/GETOUT-Platform/commit/596279488aadca4ce440e59e17061852e28c2710))


### Bug Fixes

* **add mykey.jks:** :technologist: ([6ae7497](https://github.com/EIP-GetOut/GETOUT-Platform/commit/6ae74975b2f639f633f3b2e056a514aa1106faaf))
* **app:** :art: center up the connection page ([fb5803d](https://github.com/EIP-GetOut/GETOUT-Platform/commit/fb5803d523ec38cb531bf18eb02104e83741d21d))
* **app:** :bug: :art: register validators are working again (by fixing it, there was a code structure improvement) ([77ba006](https://github.com/EIP-GetOut/GETOUT-Platform/commit/77ba006fe92e444f846c8bc3275aef6a442b3133))
* **app:** :rotating_light: fix warnings ([86f6be3](https://github.com/EIP-GetOut/GETOUT-Platform/commit/86f6be3c0ac4bdb99059de0031cdef73d67e4e92))
* **app:** :sparkles: call request for login ([b7d0048](https://github.com/EIP-GetOut/GETOUT-Platform/commit/b7d0048c509f66ea8353a3889e5ccb6c2a38457d))
* **app:** :sparkles: connection between back and front for login ([0c633b9](https://github.com/EIP-GetOut/GETOUT-Platform/commit/0c633b91232010e8f6d4e788308c85b59d37ace3))
* **backend:** :adhesive_bandage: error code in login and typo in register ([a84ed61](https://github.com/EIP-GetOut/GETOUT-Platform/commit/a84ed61a35e2cc424514287217f7866ccc405148))
* **backend:** :adhesive_bandage: path to entities ([c54e880](https://github.com/EIP-GetOut/GETOUT-Platform/commit/c54e880a17efbf66afbdc0dc33e268ce2f370001))
* **backend:** :bug: get 5 books and get the details of a single book ([7258cb7](https://github.com/EIP-GetOut/GETOUT-Platform/commit/7258cb7edb62102eeff905c38d31c12a80df578e))
* **backend:** :bug: getMovies parseInt on nullable page parameter ([a1ec937](https://github.com/EIP-GetOut/GETOUT-Platform/commit/a1ec93792645862537b572455af67d9f0a1b5a85))
* **backend:** :rotating_light: adding context to the docker-compose ([7a74603](https://github.com/EIP-GetOut/GETOUT-Platform/commit/7a7460399bcd2a19ae3fe9108f91501e95f8936d))
* **backend:** :truck: using params instead of query ([619b874](https://github.com/EIP-GetOut/GETOUT-Platform/commit/619b874231b175a6f50a791009bc04fc335df9d9))
* **backend:** error in header ([70bddbe](https://github.com/EIP-GetOut/GETOUT-Platform/commit/70bddbe2111bc851ab258a4d79067ed0b73643e1))
* **CICD:** :sparkles: fix job script name ([a220d1c](https://github.com/EIP-GetOut/GETOUT-Platform/commit/a220d1c1a317267ecfd12f4f515340bbc91d41d8))
