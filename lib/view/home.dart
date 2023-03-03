import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  var campoCpf = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Primeria Página')),
      body: Center(
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                  label: Text('CPF'), hintText: 'Informe o seu CPF'),
              controller: campoCpf,
            ),
            ElevatedButton(
              child: const Text('verificar'),
              onPressed: () {
                var resultado = validarCPF(campoCpf.text);
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

  String validarCPF(String cpfCompleto) {
    if (!cpfCompleto.contains('.')) return 'CPF deve possuir "."';
    if (!cpfCompleto.contains('-')) return 'CPF deve possuir "-"';
    if (cpfCompleto.length != 14) return 'CPF deve possuir 14 caracteres';

    var cpfSemMascara = cpfCompleto.replaceAll('.', '').replaceAll('-', '');
    var cpfListaNumeros = cpfSemMascara
        .substring(0, 9)
        .split('')
        .map<int>((e) => int.parse(e))
        .toList();
    var ehNumerosIguais = true;
    var primeiroDigito = int.parse(cpfSemMascara.substring(9, 10));
    var segundoDigito = int.parse(cpfSemMascara.substring(10, 11));

    for (var i = 1; i < cpfListaNumeros.length; i++) {
      if (cpfListaNumeros[i - 1] != cpfListaNumeros[i]) {
        ehNumerosIguais = false;
        break;
      }
    }
    if (ehNumerosIguais) return 'Cpf deve possuir números diferentes';

    var peso = 10;
    var digitoCalculado = 0;
    for (var n in cpfListaNumeros) {
      digitoCalculado += peso * n;
      peso--;
    }

    digitoCalculado = 11 - (digitoCalculado % 11);
    if (digitoCalculado > 9) digitoCalculado = 0;
    if (primeiroDigito != digitoCalculado) return 'Primeiro digito incorreto';

    cpfListaNumeros.add(digitoCalculado);
    peso = 11;
    digitoCalculado = 0;
    for (var n in cpfListaNumeros) {
      digitoCalculado += peso * n;
      peso--;
    }
    digitoCalculado = 11 - (digitoCalculado % 11);
    if (digitoCalculado > 9) digitoCalculado = 0;
    if (segundoDigito != digitoCalculado) return 'Segundo digito incorreto';

    return 'CPF valido';
  }

}
