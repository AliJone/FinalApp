import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finals/crud_firestore_bloc/repo/object_repository.dart';
import 'package:finals/crud_firestore_bloc/ui_bloc/object_bloc.dart';
import 'package:finals/crud_firestore_bloc/model/object_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finals/crud_firestore_bloc/object_bloc_ui edit.dart';

class ObjectBlocUI extends StatelessWidget {
  final ObjectRepository objectRepository = ObjectRepository(
    firebaseFirestore: FirebaseFirestore.instance,
  );

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context1) => ObjectBloc(obj: objectRepository)
        ..add(LoadUserObjectEvent()), // Event to load all objects
      child: MaterialApp(
        title: 'CRUD Operations',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Friends'),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  //navigate to /add
                  Navigator.pushNamed(context, '/add');
                },
              )
            ],
          ),
          body: BlocBuilder<ObjectBloc, ObjectState>(
            builder: (context23, state) {
              if (state is ObjectLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ObjectLoadedState) {
                return ListView.builder(
                  itemCount: state.obj.length,
                  itemBuilder: (context2, index) {
                    return Container(
                      child: ListTile(
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ObjectBlocUIEDIT(
                                  text: index.toString(),
                                ),
                              ))
                        },
                        leading: CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/google.png"),
                        ),
                        title: Text(state.obj[index].name),
                        subtitle: Text(state.obj[index].mobileNo),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                // functionality to delete object
                                BlocProvider.of<ObjectBloc>(context2).add(
                                  DeleteUserObjectEvent(obj: state.obj[index]),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text('Error loading data!'),
                );
              }
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                  backgroundColor: Colors.black,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                  backgroundColor: Colors.black,
                ),
              ],
              currentIndex: 0,
              onTap: (index) {
                if (index == 0) {
                  Navigator.pushNamed(context, "/crud");
                } else if (index == 1) {
                  Navigator.pushNamed(context, "/profile");
                }
              }),
        ),
      ),
    );
  }
}
