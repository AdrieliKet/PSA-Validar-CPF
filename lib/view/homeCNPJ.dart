import 'package:flutter/material.dart';

class HomeCNPJ extends StatelessWidget {
  HomeCNPJ({Key? key}) : super(key: key);
  var campoCNPJ = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Primeria Página')),
      body: Center(
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                  label: Text('CNPJ'), hintText: 'Informe o seu CNPJ'),
              controller: campoCNPJ,
            ),
            ElevatedButton(
              child: const Text('verificar'),
              onPressed: () {
                var resultado = validarCNPJ(campoCNPJ.text);
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Aviso'),
                        content: Text(resultado),
                      );
                    });
              },
            )
          ],
        ),
      ),
    );
  }

  String validarCNPJ(String CNPJCompleto) {
    if (!CNPJCompleto.contains('.')) return 'CNPJ deve possuir "."';
    if (!CNPJCompleto.contains('-')) return 'CNPJ deve possuir "-"';
    if (!CNPJCompleto.contains('/')) return 'CNPJ deve possuir "/"';
    if (CNPJCompleto.length != 18) return 'CNPJ deve possuir 18 caracteres';

    var CNPJSemMascara = CNPJCompleto.replaceAll('.', '')
        .replaceAll('-', '')
        .replaceAll('/', '');

    var CNPJListaNumeros = CNPJSemMascara.substring(0, 12)
        .split('')
        .map<int>((e) => int.parse(e))
        .toList();
    var ehNumerosIguais = true;
    var listaPrimeiroDigito = int.parse(CNPJSemMascara.substring(0, 12));
    var listaSegundoDigito = int.parse(CNPJSemMascara.substring(0, 13));
    var primeiroDigito = int.parse(CNPJSemMascara.substring(12, 13));
    var segundoDigito = int.parse(CNPJSemMascara.substring(13, 14));

    for (var i = 1; i < CNPJListaNumeros.length; i++) {
      if (CNPJListaNumeros[i - 1] != CNPJListaNumeros[i]) {
        ehNumerosIguais = false;
        break;
      }
    }
    if (ehNumerosIguais) return 'CNPJ deve possuir números diferentes';

    primeiroDigito =
        calcularDigitoVerificadorCNPJ(listaPrimeiroDigito.toString());
    CNPJListaNumeros.add(primeiroDigito);
    segundoDigito =
        calcularDigitoVerificadorCNPJ(listaSegundoDigito.toString());

    var digitoCalculado = int.parse(CNPJSemMascara[12]);
    if (digitoCalculado != primeiroDigito) return 'Primeiro digito incorreto';

    digitoCalculado = int.parse(CNPJSemMascara[13]);
    if (digitoCalculado != segundoDigito) return 'Segundo digito incorreto';

    return 'CNPJ valido';
  }

  int calcularDigitoVerificadorCNPJ(String parteCnpj) {
    var digitoCalculado = 0;
    var peso = 2;
    for (var i = parteCnpj.length - 1; i >= 0; i--) {
      digitoCalculado += int.parse(parteCnpj[i]) * peso;
      peso = peso == 9 ? 2 : peso + 1;
    }

    var resto = digitoCalculado % 11;
    return resto < 2 ? 0 : 11 - resto;
  }
}
