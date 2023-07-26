import 'package:agenda_usuarios_crud/models/User.dart';
import 'package:agenda_usuarios_crud/provider/usersProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserForm extends StatelessWidget {

  final _form = GlobalKey<FormState>();
  //Quando o Usuario só tem dados finais, tem que colocar os dados dentro de um MAP
  final Map<String, String> _formDada = {};

  // Metodo privado para mostrar dados do usuario na tela
  void _loadFormData(User user){
    if(user != null){
      _formDada['id'] = user.id;
      _formDada['nome'] = user.nome;
      _formDada['email'] = user.email;
      _formDada['avatarURL'] = user.avatarURL;
    }
  }

  @override
  Widget build(BuildContext context) {
    //Recebe o usuario para a Edição
    final User user = ModalRoute.of(context).settings.arguments;
    //Carrega os dados do usuario na tela caso seja edição;
    _loadFormData(user);

    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário do Usuário'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save), 
            onPressed: () {
              //Valida o formulario
              final isValidate = _form.currentState.validate();
              //Se todo o formulario for valido
              if(isValidate){
                _form.currentState.save();
                //Listen: false -> Ele não precisa ouvir as alteraçoes, pois quando salvar ele irá retornar a tela. Não acontecerá nada
                Provider.of<UsersProvider>(context, listen: false).put(
                  User(
                    //Pega os dados do formulário
                    id: _formDada['id'],
                    nome: _formDada['nome'],
                    email: _formDada['email'],
                    avatarURL: _formDada['avatarURL'],
                  ),
                );
                Navigator.of(context).pop(); //Volta pra tela anterior
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                //Carrega como valor inicial o dado de edição
                initialValue: _formDada['nome'],
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if(value == null || value.trim().isEmpty){
                    return 'Preencha o campo';
                  }
                  if(value.trim().length < 3){
                    return 'Nome muito pequeno. No minímo 3 catecteres';
                  }
                },
                onSaved: (value) => _formDada['nome'] = value,
              ),
              TextFormField(
                //Carrega como valor inicial o dado de edição
                initialValue: _formDada['email'],
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if(value == null || value.trim().isEmpty){
                    return 'Preencha o campo';
                  }

                  if(value.trim().length < 10){
                    return 'Email inválido. Email deve conter no minímo 10 caracters';
                  }
                },
                onSaved: (value) => _formDada['email'] = value,
              ),
              TextFormField(
                //Carrega como valor inicial o dado de edição
                initialValue: _formDada['avatarURL'],
                decoration: InputDecoration(labelText: 'URL do Avatar'),
                onSaved: (value) => _formDada['avatarURL'] = value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}