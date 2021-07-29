import 'package:crypto/repositories/favoritas_repository.dart';
import 'package:crypto/widgets/moeda_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritosPage extends StatefulWidget {
  const FavoritosPage({Key? key}) : super(key: key);

  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moedas Favoritas'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.indigo.withOpacity(.05),
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(12.0),
        //O consumer é onde fica ouvindo meu <Provider>
        child: Consumer<FavoritasRepository>(
          builder: (context, favoritas, child) {
            return favoritas.lista.isEmpty
                ? ListTile(
                    leading: Icon(Icons.star),
                    title: Text('Ainda não há moedas favoritadas'),
                  )
                : ListView.builder(
                    itemCount: favoritas.lista.length,
                    itemBuilder: (_, index) {
                      return MoedaCard(moeda: favoritas.lista[index]);
                    },
                  );
          },
        ),
      ),
    );
  }
}
