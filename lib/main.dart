import 'package:finals/firebase_options.dart';
import 'package:finals/login.dart';
import 'package:finals/profile.dart';
import 'package:finals/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:finals/profile_bloc/ui_bloc/profile_bloc.dart';
import 'package:finals/profile_bloc/repo/profile_repository.dart';
import 'package:finals/crud_firestore_bloc/ui_bloc/object_bloc.dart';
import 'package:finals/crud_firestore_bloc/repo/object_repository.dart';
import 'package:finals/crud_firestore_bloc/object_bloc_ui.dart';
import 'package:finals/crud_firestore_bloc/object_bloc_ui add.dart';
import 'package:finals/crud_firestore_bloc/object_bloc_ui edit.dart';

import 'package:finals/data_bloc/data_bloc_ui.dart';
import 'package:finals/profile_bloc/profile_bloc_ui.dart';
import 'home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(
              profileRepository: ProfileRepository(
                  firebaseFirestore: FirebaseFirestore.instance)),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        initialRoute: '/add',
        routes: {
          '/': (BuildContext context) => LoginPage(),
          '/add': (BuildContext context) => BlocProvider<ObjectBloc>(
                create: (context) => ObjectBloc(
                  obj: ObjectRepository(
                    firebaseFirestore: FirebaseFirestore.instance,
                  ),
                ),
                child: ObjectBlocUIADD(),
              ),
          // '/edit': (BuildContext context) => BlocProvider<ObjectBloc>(
          //       create: (context) => ObjectBloc(
          //         obj: ObjectRepository(
          //           firebaseFirestore: FirebaseFirestore.instance,
          //         ),
          //       ),
          //       child: ObjectBlocUIEDIT(),
          //     ),
          // '/login': (BuildContext context) => LoginPage(),
          // '/signUp': (BuildContext context) => SignUp(),
          '/crud': (BuildContext context) => BlocProvider<ObjectBloc>(
                create: (context) => ObjectBloc(
                  obj: ObjectRepository(
                    firebaseFirestore: FirebaseFirestore.instance,
                  ),
                ),
                child: ObjectBlocUI(),
              ),
          '/profile': (BuildContext context) => Profiling(),
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
