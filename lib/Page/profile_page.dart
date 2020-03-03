import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanmakan/Bloc/user_profile/bloc/bloc.dart';
import 'package:scanmakan/Widget/profile_tile.dart';
import 'package:scanmakan/model/user_model.dart';

class ProfillePage extends StatelessWidget {
  var model = UserModel.dummy();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("Data Diri"),
        ),
        body: BlocProvider<UserProffileBloc>(
          create: (context) => UserProffileBloc(),
          child: BlocBuilder<UserProffileBloc, UserProffileState>(
            builder: (context, state) {
              if(state is InitialUserProffileState){
                BlocProvider.of<UserProffileBloc>(context).add(RequestUserProffile());
              }
              if(state is UserProffileFounded){
                print("User found");

                return ProfiileTile(model: state.result);
              }
              if(state is ErrorUserProffileState){
                return new Text("woops");
              }
              return Center(

                  child: new CircularProgressIndicator());
            },
          ),
        ));
  }
}
