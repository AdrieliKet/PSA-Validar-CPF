import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  var campoCpf = TextEditingController();

  String validar(String cpf) {
    // temporário apagar
    var cpfCompleto = cpf;
    // >>>>>>>>>>>>>>>>>>

    if (!cpfCompleto.contains('.')) return 'CPF deve possuir "."';
    if (cpfCompleto.contains('-')) return 'CPF deve possuir "-"';
    if (cpf.length == 14) return 'CPF deve possuir 14 caracteres';
    

    var temp,
        temp2,
        temp3,
        temp4,
        temp5,
        temp6,
        temp7,
        temp8,
        temp9,
        temp10,
        temp11,
        temp12,
        temp13,
        temp14,
        temp15;

    cpfCompleto = cpfCompleto.replaceAll('.', '');
    cpfCompleto = cpfCompleto.replaceAll('-', '');
    cpfCompleto = cpfCompleto.split('');

    temp4 = true;
    for (int c = 0; c < temp3.length - 1; c++) {
      if (temp3[c] == temp3[c + 1]) {
        temp4 = false;
      } else {
        temp4 = true;
        break;
      }
    }
    if (temp4) {
      temp5 = temp2.substring(0, 9).split('').map(int.parse).toList();
      temp6 = 0;
      temp7 = 10;
      temp8 = 0;
      for (var n in temp5) {
        temp8 = temp7 * n + temp8;
        temp7--;
      }
      temp9 = 11 - (temp8 % 11);
      if (temp9 > 9) {
        temp9 = 0;
      } else {
        temp9 = temp9;
      }
      temp10 = int.parse(cpf.substring(12, 13));
      if (temp9 == temp10) {
        temp11 = temp2.substring(0, 10).split('').map(int.parse).toList();
        temp12 = 11;
        temp13 = 0;
        for (var n in temp11) {
          temp13 = temp12 * n + temp13;
          temp12--;
        }
        temp14 = 11 - (temp13 % 11);
        if (temp14 > 9) {
          temp14 = 0;
        } else {
          temp14 = temp14;
        }
        temp15 = int.parse(cpf.substring(13, 14));
        if (temp14 == temp15) {
          return 'CPF válido';
        } else {
          return 'CPF inválido';
        }
      } else {
        return 'CPF inválido';
      }
    } else {
      return 'CPF inválido';
    }
  }

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
                var resultado = validar(campoCpf.text);
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
}
