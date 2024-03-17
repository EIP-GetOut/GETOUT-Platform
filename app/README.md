# GetOut

## Getting Started

# Getout Flutter Application Contributor

- Perry Chouteau
- Erwan Cariou
- Inès Maaroufi

# Folder construction

## Firstly you can find at the root of app:

`assets/`: contains font, image(jpg, png, svg, raw..)
`lib/`: contains the main part of the project (flutter code, etc..)
`android/`: android (use for specific os edition: .gradle, Manifest.xml..)
`ios/`: ios (use for specific os edition..)

`.dart_tool`: contains lot of unreadable stuff and also `flutter_gen`,
its this folder you can find flutter generation code used by some
packages like `flutter_localizations`.

## Now let's talk about lib the main part of the app.

This project is build with two type of folder `specified_folder` and `anywhere_folder`.

`specified_folder` can only be found at the root of `lib/`:
- `constants/` contains all constant variables used in the app.
- `docs/` contains all the docs needed to use, fix or improve the app.
- `l10n/` contains all text & translation used in the app for multi language purose.
- `screens/` It's the main part of `lib/` contains pages(ui, logic, service(request, more_logic)).
- `tools/` contains tools used in all the app such as enum, class or function.

`anywhere_folder` can be found anywhere in sub-folders of `lib/` cause it's sort
following usage, the most they are used in a lot of place, the closer
they will be from the root (`anywhere_folder` are not mandatory.. only used where it's needed):
- `bloc/` this folder can be found anywhere it contains blocs folder (the logic part handling data)
- `widgets/` pages can use multiple time the same ui object called widget.
- `pages` similar to screen it regroup pages closer or further of the root.


## Pages


