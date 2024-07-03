// /*
// ** Copyright GETOUT SAS - All Rights Reserved
// ** Unauthorized copying of this file, via any medium is strictly prohibited
// ** Proprietary and confidential
// ** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
// */

// import 'package:flutter/material.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:getout/screens/connection/login/bloc/login_bloc.dart';
// import 'package:getout/tools/app_l10n.dart';

// class EmailField extends StatelessWidget {
//   const EmailField({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<LoginBloc, LoginState>(
//       builder: (context, state) {
//         return TextFormField(
//           style: const TextStyle(fontSize: 10),
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: const Color(0xffeaeaea),
//             labelText: appL10n(context)!.email_hint,
//             labelStyle: TextStyle(color: Colors.black.withOpacity(0.25)),
//             floatingLabelBehavior: FloatingLabelBehavior.never,
//             enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: const BorderSide(color: Color(0xffeaeaea))),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           validator: (value) =>
//               state.isEmailEmpty ? null : appL10n(context)!.email_validator,
//           onChanged: (value) =>
//               context.read<LoginBloc>().add(LoginEmailChanged(email: value)),
//         );
//       },
//     );
//   }
// }

// class PasswordField extends StatelessWidget {
//   const PasswordField({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
//       return TextFormField(
//         obscureText: true,
//         style: const TextStyle(fontSize: 17, color: Colors.black),
//         decoration: InputDecoration(
//             labelText: appL10n(context)!.password_hint,
//             floatingLabelBehavior: FloatingLabelBehavior.never,
//             enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(0.5),
//                 borderSide: const BorderSide(color: Colors.black)),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(0.5),
//             )),
//         validator: (value) =>
//             state.isPasswordEmpty ? null : appL10n(context)!.password_validator,
//         onChanged: (value) => context
//             .read<LoginBloc>()
//             .add(LoginPasswordChanged(password: value)),
//       );
//     });
//   }
// }
