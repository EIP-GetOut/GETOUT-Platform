# GETOUT-Platform

## Introduction

Welcome to our application GetOut : The Social Media Time Reducer application!

In today's world, social media can be a great way to stay connected with friends and family, but it can also be a major source of distraction and time-wasting. That's why we've created this application - to help you reduce the time you spend on social media and instead suggest alternative activities such as books, films, and other activities that you may enjoy.

Our application is designed to be user-friendly and easy to use. Simply input how much time you would like to spend on social media each day, and our app will help you stay within that limit. We'll suggest activities based on your interests and preferences, so you can find new and exciting ways to spend your time without getting sucked into the endless scroll of social media.

We hope that our application will help you take back control of your time and make the most of every day.

## Build

### Build for Linux and MacOs

To build :


```bash
./build_unix.sh
```

To Setup the pre-commit hook :
```bash
pip install pre-commit
pre-commit --version # to check that it is installed successfully
pre-commit install
pre-commit install --hook-type commit-msg
```

To clean and rebuild from scratch :

```bash
./build_unix.sh re
```

Tu clean the repo :

```bash
./build_unix.sh clean
```

### Build for Windows


To build :

```bash
./build_windows.bat
```

To clean and rebuild from scratch :

```bash
./build_windows.bat re
```

Tu clean the repo :

```bash
./build_windows.bat clean
```

## Installation

Clone the repository, then run the following commands:

```bash
./instalation.sh
./GetOut
```

## Start the front

```bash
flutter run
```

If you want to test it on web:
```bash
flutter run -d chrome --web-renderer html
```

## Documentation

You can find all the documentation in the file "doc" :

```bash
cd doc
```

## Authors

- [Alexandre Chetrit](https://github.com/chetrit)
- [Théo de Boysson](https://github.com/BoyssonFresh)
- [Julien Letoux](https://github.com/lockhead)
- [Ines Maaroufi](https://github.com/Happinesseuh)
- [Perry Chouteau](https://github.com/Perry-chouteau)
- [Erwan Cariou](https://github.com/ErwanC7)
- [Zacharie Lawson](https://github.com/zachmae)