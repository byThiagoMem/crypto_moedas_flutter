import 'package:crypto/models/moeda.dart';

class MoedaRepository {
  static List<Moeda> tabela = [
    Moeda(
      icone: "assets/images/bitcoin_icon.png",
      nome: 'Bitcoin',
      sigla: 'BTC',
      preco: 164603.00,
    ),
    Moeda(
      icone: "assets/images/ethereum_icon.png",
      nome: 'Ethereum',
      sigla: 'ETH',
      preco: 9616.00,
    ),
    Moeda(
      icone: "assets/images/xrp_icon.png",
      nome: 'XRP',
      sigla: 'XRP',
      preco: 3.34,
    ),
    Moeda(
      icone: "assets/images/cardano_icon.png",
      nome: 'Cardano',
      sigla: 'ADA',
      preco: 6.32,
    ),
    Moeda(
      icone: "assets/images/usd_coin_icon.png",
      nome: 'USD Coin',
      sigla: 'USDC',
      preco: 5.02,
    ),
    Moeda(
      icone: "assets/images/litecoin_icon.png",
      nome: 'Litecoin',
      sigla: 'LTC',
      preco: 669.93,
    ),
  ];
}
