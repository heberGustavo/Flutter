import 'package:agenda_usuarios_crud/components/user_tile.dart';
import 'package:agenda_usuarios_crud/provider/usersProvider.dart';
import 'package:agenda_usuarios_crud/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Irá ser notificado quando ocorrer alguma ação na lista(Edição, Exclusão). Quando o Provider não tem 'Listen: false' significa que ele é 'true';
    final UsersProvider usuarios = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Usuários'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add), 
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.USER_FORM
              );
            } ),
        ],
      ),
      body: ListView.builder(
        itemCount: usuarios.count,
        itemBuilder: (cxt, i) => UserTile(usuarios.byIndex(i)),
        ),
    );
  }
}