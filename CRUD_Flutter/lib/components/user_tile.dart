import 'package:agenda_usuarios_crud/models/User.dart';
import 'package:agenda_usuarios_crud/provider/usersProvider.dart';
import 'package:agenda_usuarios_crud/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {

final User user;

const UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarURL == null || user.avatarURL.isEmpty 
                  ? CircleAvatar(child: Icon(Icons.person))
                  : CircleAvatar(backgroundImage: NetworkImage(user.avatarURL));
    return ListTile(
      leading: avatar,
      title: Text(user.nome),
      subtitle: Text(user.email),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            //Botão de Editar
            IconButton(icon: Icon(
              Icons.edit), 
              color: Colors.orange,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.USER_FORM,
                  //Enviar usuario como argumento para Edição
                  arguments: user,
                );
              },
              ),
              //Botão de Excluir
              IconButton(
                icon: Icon(Icons.delete), 
                color: Colors.red,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text('Exclusão de Usuário'),
                      content: Text('Deseja confirmar exclusão do Usuário?'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Não'),
                          onPressed: () {
                            //Fecha o Dialog
                            Navigator.of(context).pop();
                          }, 
                        ),
                        FlatButton(
                          child: Text('Sim'),
                          onPressed: () {
                            //Não vai ser notificado. Listen:false;
                            Provider.of<UsersProvider>(context, listen: false).remove(user);    
                            //Fecha o Dialog
                            Navigator.of(context).pop();
                          }, 
                        ),
                      ],
                    ),
                    );                
                },
                ),
          ],
        ),
      ),
    );
  }
}