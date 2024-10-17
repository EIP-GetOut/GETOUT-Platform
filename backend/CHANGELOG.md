# Changelog

All notable changes to this project will be documented in this file. See [standard-version](https://github.com/conventional-changelog/standard-version) for commit guidelines.

### [0.7.1](https://github.com/EIP-GetOut/GETOUT-Platform/compare/v0.7.0...v0.7.1) (2024-09-13)


### Features

* **app:** :sparkles: carrousel recommendations movie & book. ([52275bf](https://github.com/EIP-GetOut/GETOUT-Platform/commit/52275bf9685b15fdb6d716f182924c6bd876ffaa))
* **app:** :sparkles: form have a loading button + 3 choices limit ([#99](https://github.com/EIP-GetOut/GETOUT-Platform/issues/99)) ([fec69f0](https://github.com/EIP-GetOut/GETOUT-Platform/commit/fec69f09f95452e67fea52354fb17de7e39dd8c4))
* **app:** ✨ book details new UI ([#100](https://github.com/EIP-GetOut/GETOUT-Platform/issues/100)) ([7779b7f](https://github.com/EIP-GetOut/GETOUT-Platform/commit/7779b7f64992eee3e35f13cbc151d84cac3946f4))


### Bug Fixes

* **app:** :art: typo ([c5b08f7](https://github.com/EIP-GetOut/GETOUT-Platform/commit/c5b08f7974c65d0a977de9b651f71545d80fbb43))
* **app:** :bug: form loading come back to a normal button after failing ([eff2f59](https://github.com/EIP-GetOut/GETOUT-Platform/commit/eff2f59e93675abcb4bd553b8892827b7121284a))

## [0.7.0](https://github.com/EIP-GetOut/GETOUT-Platform/compare/v0.6.5...v0.7.0) (2024-09-12)


### Features

* **backend:** :sparkles: Add a weight for the algorythme of books ([1cf1bf4](https://github.com/EIP-GetOut/GETOUT-Platform/commit/1cf1bf420b5bf354bd0edf2deb2f55699c038941))
* **backend:** :sparkles: add favorite authors to fetch the book pool ([8f897f0](https://github.com/EIP-GetOut/GETOUT-Platform/commit/8f897f0a24d0467ee9546c1f9461fc5923f99031))
* **backend:** :sparkles: add random books if there is not enough books in the pool after all the fetches ([fc7f7c7](https://github.com/EIP-GetOut/GETOUT-Platform/commit/fc7f7c7c0c9a255bd46b59c9aa69e4117db968d6))
* **backend:** :sparkles: Add the weight in the algorythme for the films ([f198d91](https://github.com/EIP-GetOut/GETOUT-Platform/commit/f198d91b917e0d54e35aff00390a16f331d67c30))
* **backend:** :sparkles: get a first pool by genres from the form ([34e8220](https://github.com/EIP-GetOut/GETOUT-Platform/commit/34e82209553a69bebf6b51de379efaba51d846bb))
* **backend:** :sparkles: get pool by genres and liked genres ([71d0176](https://github.com/EIP-GetOut/GETOUT-Platform/commit/71d0176c48569ee1f0addbd38679a28ec59a9f82))
* **backend:** :sparkles: print function indent 2 ([3729a05](https://github.com/EIP-GetOut/GETOUT-Platform/commit/3729a0500fb5a1157d1e060c382c9399cb51b446))
* merge branch 'dev' of github.com:EIP-GetOut/GETOUT-Platform into feature/recommendations ([7186fc2](https://github.com/EIP-GetOut/GETOUT-Platform/commit/7186fc2c9e247d45786120016d8f4bf2f6e521e7))


### Bug Fixes

* **backend:** :bug: poster path of books and integer scoring ([6073bff](https://github.com/EIP-GetOut/GETOUT-Platform/commit/6073bff9337c4f474c893408ba54a3e785aac1fd))
* **backend:** :bug: The algorythme for the books and the films was only reading the first genre of the preferences ([0ba1dec](https://github.com/EIP-GetOut/GETOUT-Platform/commit/0ba1dec7f15a7395dc8cf70b956c5648032dbb35))
* **backend:** :bug: unit tests timeout ([30bd0b7](https://github.com/EIP-GetOut/GETOUT-Platform/commit/30bd0b702866f9e2912efc8bc920cedf493b6c34))
* **backend:** :bug: Wasn't using the good score in the algorythme ([6a0375f](https://github.com/EIP-GetOut/GETOUT-Platform/commit/6a0375f05ef8ae10092365858d81e2a6c7a21655))


### Refactors

* **backend:** :recycle: refactor code, split the 3 main functions into multiple ones ([533927e](https://github.com/EIP-GetOut/GETOUT-Platform/commit/533927e03654125941e6fc2481318e318622e28d))
