# GetOut Coding Style

## File Naming

- File names **MUST** be in **snake_case**, all lowercase, with words separated by underscores.


- In case of a file containing a class, the file name **SHOULD** be the **same as the class name**.<br />
For example, a file containing the class `MyClass` **SHOULD** be named `my_class.dart`.


- In case of file containing a class that as a suffix (like `page`), the file name **SHOULD** be the **same as the class name, but without the suffix**.<br />
For example, a file containing the class `LoginPage` **SHOULD** be named `login.dart`.


- 


- All file **MUST** be placed in the right folder.

## Header of file

### Comment header

- All file **MUST** have a header containing the following information:<br />

```dart
/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
*/
```

### Import

- Import **MUST** be **spaced from the comment header** by **one line**.


- Import **MUST** be **space separated list of imports** and should be in this order :<br />
dart + flutter package -> extern package -> app package <br />
For example :
```dart
import 'dart:async';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:my_app/screen/my_page.dart';
import 'package:my_app/screen/my_page.dart';
```

## Class

Class names **MUST** be in **UpperCamelCase** (PascalCase), with no underscores and Upper case letters at the beginning of each word.

Class constructor **SHOULD** be **const**

### Method

Methods respect the **same rules as functions**.

### Variable

- Variable **SHOULD** be **private** (start with an underscore).


- Variable in class respect the **same rules as other variable**.

## Variable

- **ALWAYS** use **final or const** when possible and **AVOID using var or dynamic**.


- Variable names **MUST** be in camelCase, with no underscores and Upper case letters at the beginning of each word except for the first one.


- Variable **SHOULD** be named in English or abbreviation of an English words.


- Variable **MUST** be **typed**.


- Constant global variable names **MUST** be in **UPPER_SNAKE_CASE**, with no underscores and Upper case letters at the beginning of each word.

## Function

- Function names **MUST** be in **camelCase**, with no underscores and Upper case letters at the beginning of each word.


- Function **MUST** be **typed**.


- First brace **MUST** be in a new line.

### Function parameter

- Function parameter **MUST** be in **camelCase**.


- Function parameter **MUST** be **typed**.


- Function parameter **SHOULD** be **final**.

### Function variable

Function variable respect the **same rules as other variable**.
<br>
<br>

Example :
```dart
String fooFunction(final int myNbr, final int yourNbr)
{
  final int myResult = nbr + nbr2;

  return myResult.toString();
}
```

## Formatting

### Indentation

Indentation **MUST** be done with **2 spaces**.

### Line Length

Lines **SHOULD NOT** be longer than **80 characters**.

_There is an exception, when a String purpose is not to be read by a human. (For example, a long URL)_

### Syntax

**PREFER** use single quotes for String.

**MUST** use curly braces for all flow control statements (if, for, etc).
```dart
if (isRaining()) {
  you.bringRainCoat();
}
```

_There is an exception in some widget if statement can be in one line like this :_<br >
```dart
if (isLoading == false) Scafold(...);
```

## Other Cases

In other cases, you **SHOULD** follow the [Effective Dart](https://dart.dev/guides/language/effective-dart/style) style guide.