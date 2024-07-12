# UserBloc

C'est un bloc a donner perssistence on passe de:

> `globals.dio (type:Dio)`
> 
> `globals.session (type:dynamic)`

A cela `final UserState state = context.watch<UserBloc>().state`, UserState contient ceci:

> `this.cookiePath (type:String)`
> 
> `this.account (type:Account?)` 

récupérer au UserBloc.on<LoginEvent> comme l'ancien getSession dans le but de récup les données du compte après le login (une seul fois).

## Connection

## Register
- 
- noBLoC
- inputGeneric Voir `lib/fields/widget` (exception faites au birthdate qui est assez spéciale pour être aussi mis dans widget mais sans héritage de `defaultInput`)
- REQUEST_REGISTER qui renvoie la réponse gérer dans le widget.
  - ERROR -> input.errorMessage
  - SUCCESS -> popToLogin

## Login

- noBLoC
- inputGeneric Voir `lib/fields/widget`
- REQUEST_LOGIN qui renvoie la réponse gérer dans le widget.
  - ERROR: -> input.errorMessage \-> (exception: loginOnAlreadyLogin-> voirProcessSUCCESS).
  - SUCCESS -> (Dio est donc récupérer) on<LoginEvent> qui récupère Account et mets à jour le status de l'app.
    - `Status.Login` if Pref are empty
    - `Status.LoginWithPref` if Pref are not empty

## ForgotPassword

- noBLoC
- inputGeneric Voir `lib/fields/widget`
- (need to make it work)...