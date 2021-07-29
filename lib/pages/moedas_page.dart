import 'package:crypto/configs/app_settings.dart';
import 'package:crypto/models/moeda.dart';
import 'package:crypto/pages/moedas_detalhes_page.dart';
import 'package:crypto/repositories/favoritas_repository.dart';
import 'package:crypto/repositories/moeda_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MoedasPage extends StatefulWidget {
  const MoedasPage({Key? key}) : super(key: key);

  @override
  _MoedasPageState createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
  final tabela = MoedaRepository.tabela;
  late NumberFormat real;
  late Map<String, String> loc;
  late Map<String, String> theme;
  List<Moeda> selecionadas = [];
  late FavoritasRepository favoritas;

  //Função para ler as preferencias de localização da classe AppSettings
  readNumberFormat() {
    //Acessando o Provider direto
    loc = context.watch<AppSettings>().locale;
    real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
  }

  readThemePreferences() {
    theme = context.watch<AppSettings>().theme;
  }

  //Botão para alterar a linguagem no preferences
  changeLanguageButton() {
    final locale = loc['locale'] == 'pt_BR' ? 'en_US' : 'pt_BR';
    final name = loc['locale'] == 'pt_BR' ? '\$' : 'R\$';

    return PopupMenuButton(
      icon: Icon(Icons.language),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.swap_vert),
            title: Text('Usar $locale'),
            onTap: () {
              context.read<AppSettings>().setLocale(locale, name);
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }

  //Botão para alterar ao tema no preferences
  changeThemeButton() {
    final themePrefences = theme['theme'] == 'light' ? 'dark' : 'light';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: IconButton(
        icon: Icon(Icons.dark_mode),
        onPressed: () {
          context.read<AppSettings>().setTheme(themePrefences);
        },
      ),
    );
  }

  //Método que navega para a página de detalhes da moeda clicada
  mostrarDetalhes(Moeda moeda) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MoedasDetalhesPage(moeda: moeda),
      ),
    );
  }

  //Método para limpar os favoritos
  limparSelecionadas() {
    setState(() {
      selecionadas = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    //favoritas = Provider.of<FavoritasRepository>(context);
    favoritas = context.watch<FavoritasRepository>();
    readNumberFormat();
    readThemePreferences();
    return Scaffold(
      appBar: appBarDynamic(),
      body: ListView.separated(
        itemBuilder: (_, index) {
          return ListTile(
            leading: !selecionadas.contains(tabela[index])
                ? Image.asset(
                    tabela[index].icone,
                    width: 40,
                  )
                : Icon(Icons.check),
            title: Row(
              children: [
                Text(
                  tabela[index].nome,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (favoritas.lista.contains(tabela[index]))
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15,
                  )
              ],
            ),
            trailing: Text(
              real.format(tabela[index].preco),
              style: TextStyle(fontSize: 15),
            ),
            selected: selecionadas.contains(tabela[index]),
            selectedTileColor: Colors.indigo[50],
            onLongPress: () {
              setState(() {
                (selecionadas.contains(tabela[index]))
                    ? selecionadas.remove(tabela[index])
                    : selecionadas.add(tabela[index]);
              });
            },
            onTap: () => mostrarDetalhes(tabela[index]),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          );
        },
        separatorBuilder: (_, __) {
          return Divider();
        },
        itemCount: tabela.length,
        padding: EdgeInsets.all(12.0),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: selecionadas.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                favoritas.saveAll(selecionadas);
                limparSelecionadas();
              },
              icon: Icon(Icons.star),
              label: Text(
                'FAVORITAR',
                style: TextStyle(
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
    );
  }

  appBarDynamic() {
    if (selecionadas.isEmpty) {
      return AppBar(
        title: Text('Crypto Moedas'),
        centerTitle: true,
        actions: [changeLanguageButton(), changeThemeButton()],
      );
    } else {
      return AppBar(
        leading: BackButton(
          onPressed: () {
            setState(() {
              selecionadas = [];
            });
          },
        ),
        title: Text(
          '${selecionadas.length} selecionada${selecionadas.length > 1 ? 's' : ''}',
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[50],
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black87),
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
  }
}
