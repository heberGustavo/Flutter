//Controla a lista, Map de usuarios
import 'dart:math';

import 'package:agenda_usuarios_crud/data/dummy_users.dart';
import 'package:agenda_usuarios_crud/models/User.dart';
import 'package:flutter/cupertino.dart';

//Sempre que tiver uma mudança irá notificar os listiner e a interface vai ser atualizada
class UsersProvider with ChangeNotifier{
  final Map<String, User> _items = {...DUMMY_USERS};

  List<User> get all{
    //Cria um clona dos _items. 
    //Não cria referencia do metodo pq parte da aplicação irá pode incluir, excluir, mexer sem que a classe seja notificada
    return [..._items.values]; 
  }

  int get count{
    return _items.length;
  }

  User byIndex(int i){
    return _items.values.elementAt(i);
  }

  void put(User user){
    if(user == null){
      return;
    }

    //Atualização
    if(user.id != null && user.id.trim().isNotEmpty && _items.containsKey(user.id)){
      _items.update(user.id, (_) => user);
    }
    else{
    //Adiciona
      final id = Random().nextDouble().toString();
      _items.putIfAbsent(id, () => User(
          id: id,
          nome: user.nome, 
          email: user.email,
          avatarURL: user.avatarURL
          ));
    }
    //Informa que ocorreu mudanças e atualiza a tela
    notifyListeners();
  }

  void remove(User user){
    if(user != null && user.id != null){
      _items.remove(user.id);
      notifyListeners();
    }
  }


}