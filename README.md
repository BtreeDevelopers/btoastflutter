# b-toast

> Uma biblioteca de toasts para Flutter

O `b-toast` é uma biblioteca de toasts simples e personalizáveis para Flutter. Ele fornece um widget fácil de usar para exibir notificações no estilo toast em seu aplicativo.

![](https://raw.githubusercontent.com/BtreeDevelopers/btoastflutter/main/exemplo.gif)

## Recursos

- Exibe notificações de estilo toast de forma simples e elegante.
- Personalizável para atender às necessidades do seu aplicativo.
- Suporte a tipos de toasts: sucesso, erro, aviso, informativo, etc.
- Fácil integração com projetos Flutter existentes.

## PUB.DEV

https://pub.dev/packages/btoast

## Instalação

```bash
$ flutter pub add btoast
```

## Uso

Exibir toasts
```dart
import 'package:btoast/btoast.dart';

// Context e o conteúdo são obrigatórios 
 BToast.show(context, "Conteúdo do toast"),

// Os outros campos são opcionais 
 BToast.show(context, "Conteúdo do toast", duration: 20, theme: Type.WARNING, isDark: true,title: 'Teste');
```

Remover todos os toasts
```dart
import 'package:btoast/btoast.dart';

 BToast.hide(),
```

## Props

Aqui estão as propriedades disponíveis para o componente `b-toast`:

| Atributo |  Tipo   |  Inicial  | Descrição                                                                                                                       |
| :------- | :-----: | :-------: | :------------------------------------------------------------------------------------------------------------------------------ |
| context  | Context  |    --     | Context da aplicação. (requerido)                                                                                         |
| content  | String  |    --     | Define o conteúdo no toast. (requerido)                                                                                         |
| type     | String  | `SUCCESS` | Oefine o tipo de toast. Pode ser `SUCCESS`, `ERROR`, `WARNING`, `INFO`, ou qualquer outro tipo personalizado.                   |
| duration | Number  |  `5`   | Define a duração em segundos que o toast ficará visível antes de ser fechado automaticamente. Padrão: `5000` (5 segundos). |
| isDark   | Boolean |  `false`  | Define o tema padrão do toast. Padrão: `false`. |
| title   | String |  `""`  | Define o titulo do toast. Padrão: `""`. |

## Design Baseado em Pine UI

O design deste projeto de toasts, `b-toast`, foi desenvolvido com base no Pine UI, um design system moderno e flexível para design de interfaces. O Pine UI fornece um conjunto abrangente de componentes e estilos consistentes que ajudaram a moldar a aparência e a experiência do b-toast.

Para obter mais informações sobre o Pine UI, você pode visitar o [Pine UI](https://www.behance.net/gallery/161882269/Design-System-Pine-UI-v1-bTree) e explorar os recursos e a documentação fornecidos.

## Licença

Este projeto está licenciado sob a [MIT License](https://opensource.org/licenses/MIT).

## Outras versões

 - Disponivel para Vue 2 [NPM](https://www.npmjs.com/package/b-toast)