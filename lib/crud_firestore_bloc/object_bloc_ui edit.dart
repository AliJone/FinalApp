import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finals/crud_firestore_bloc/repo/object_repository.dart';
import 'package:finals/crud_firestore_bloc/ui_bloc/object_bloc.dart';
import 'package:finals/crud_firestore_bloc/model/object_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ObjectBlocUIEDIT extends StatelessWidget {
  final String text;
  ObjectBlocUIEDIT({required this.text});
  final ObjectRepository objectRepository = ObjectRepository(
    firebaseFirestore: FirebaseFirestore.instance,
  );
// int.parse(text)

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (contexts) => ObjectBloc(obj: objectRepository)
        ..add(LoadUserObjectEvent()), // Event to load all objects
      child: MaterialApp(
        title: 'CRUD Operations',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Edit'),
          ),
          body: BlocBuilder<ObjectBloc, ObjectState>(
            builder: (context1, state) {
              if (state is ObjectLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ObjectLoadedState) {
                _nameController.text = state.obj[int.parse(text)].name;
                _mobileNoController.text = state.obj[int.parse(text)].mobileNo;
                _emailController.text = state.obj[int.parse(text)].email;
                return Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.black,
                            )),
                            fillColor: Colors.black,
                            labelText: 'Name',
                            labelStyle: TextStyle(color: Colors.black),
                            suffixIcon: Icon(Icons.person),
                            suffixIconColor: Colors.black,
                            focusColor: Colors.black,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.black,
                            ))),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.black,
                            )),
                            fillColor: Colors.black,
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.black),
                            suffixIcon: Icon(Icons.email),
                            suffixIconColor: Colors.black,
                            focusColor: Colors.black,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.black,
                            ))),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        controller: _mobileNoController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.black,
                            )),
                            fillColor: Colors.black,
                            labelText: 'Mobile No.',
                            labelStyle: TextStyle(color: Colors.black),
                            suffixIcon: Icon(Icons.mobile_friendly),
                            suffixIconColor: Colors.black,
                            focusColor: Colors.black,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.black,
                            ))),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50), // NEW
                            ),
                            onPressed: () {
                              if (_nameController.text.isNotEmpty &&
                                  _mobileNoController.text.isNotEmpty &&
                                  _emailController.text.isNotEmpty) {
                                ObjectModel updatedObj = ObjectModel(
                                  name: _nameController.text,
                                  mobileNo: _mobileNoController.text,
                                  email: _emailController.text,
                                  id: state.obj[int.parse(text)].id,
                                );
                                BlocProvider.of<ObjectBloc>(context1).add(
                                  UpdateUserObjectEvent(obj: updatedObj),
                                );
                                Navigator.pushNamed(context, "/crud");
                              } else {
                                print("Please fill all the fields");
                              }
                            },
                            child: Text('Submit'),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Text('Error loading data!'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
