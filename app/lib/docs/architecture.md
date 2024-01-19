#Perry Chouteau <perry.chouteau@epitech.eu>


#how to create a bloc folder

lib/
    bloc/
        /*...*/
    constants/
        X.dart
    docs/
        '.md' or '.yml'
    l10n/
        app_xx.arb
    screens/
        connection/
            bloc/
            services/
            pages/
            widgets/
        homepage/
            /*...*/
    widget/
    tools/
    main.dart

# blocs format
bloc/
    X/
        (X)bloc.dart
        (X)event.dart (could be shared between multiple blocs)
        (X)state.dart
        (X)data.dart (optional)

# constants:   

constants/
    .dart

# l10n (XX define the 2character of langue, example: fr, en, es):

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
  <or>
    group_screen_name/ (group_screen)
        blocs/
        children/
            single_screen/
            /***/
        services/
        pages/
        widgets/

# widget

widget/
    .dart
  <or>
    group/
        .dart

# tools

tools/
    .dart (no class, no ui, only mapping/calculus.. function).