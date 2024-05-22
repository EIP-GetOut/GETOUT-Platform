Perry Chouteau <perry.chouteau@epitech.eu>

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


## Screens & Pages

Ui part used bloc to display data

## Bloc

build of 4 or less different parts: bloc, event, state, provider, repository.
bloc is a mandatory part for any bloc.
event, state and data are not always needed
- event defined class used in bloc method
- state define data handled by a bloc (not sure but class can probably be shared between multiple bloc with same data type.)
- provider mandatory part but can provide multiple bloc then can be defined outside of (X)/ (ex: look down)
- repository used to make request using service (can be replaced by service in lot of use)

bloc/
    (X')_provider.dart (allow us to provide one or more bloc in centralised place)
    X/
        (X)_bloc.dart
        (X)_event.dart (could be shared between multiple blocs) (optional)
        (X)_state.dart
        (X)_data.dart (optional)

___
___
___
___

## l10n `meaning localisation` (XX define the 2character of langue, example: fr, en, es):

l10n/
    app_XX.arb

# screen

a screen or group-screen are made like this

screens/
    screen_name/ (single_screen)
        bloc/
        services/
        pages/
        widgets/
< or >
    group_screen_name/ (group_screen)
        blocs/
        children/
            single_screen/
            /***/
        services/
        pages/
        widget/

# widget

widget/
.dart
<or>
group/
.dart

# tools

tools/
.dart (no class, no ui, only mapping/calculus.. function).
