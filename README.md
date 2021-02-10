# Prettier AdvPL Plugin

<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->

[![All Contributors](https://img.shields.io/badge/all_contributors-1-orange.svg?style=flat-square)](#contributors-)

<!-- ALL-CONTRIBUTORS-BADGE:END -->

## Instalação 

Primero, efetuar a instalação do [Prettier](https://prettier.io/docs/en/install.html) e em seguida esta extensão.

Para uso local:
```
npm install prettier-plugin-advpl --save-dev
```

Para uso global:
```
npm install prettier-plugin-advpl -g
```

## Opções

### Prettier

Para [detalhes sobre configuração e chaves](https://https://prettier.io/docs/en/options.html) do Prettier.
Abaixo, configurações do _Prettier_ utilizados pela extensão.

| Chave                | Uso                                                                   |
| -------------------- | --------------------------------------------------------------------- |
| --tab-width <int>    | Número de espaços por nível de indentação.                            |
|                      | Padrão: 2                                                             |
| --use-tabs           | Recuar com tabulações em vez de espaços.                              |
|                      | Padrão: false                                                         |
| --insert-pragma      | Insere '@format' no inicio do do arquivo.                             |
|                      | Padrão false                                                          |
| --require-pragma     | Requer que '@prettier' ou '@format' esteja presente no arquivo.       |
|                      | Padrão: false                                                         |
| -w, --write          | Grava o arquivo formato. Cuidado: o arquivo original será sobrescrito.|
|                      | Padrão: false                                                         |

### AdvPL

Chaves específicas para formatação de fontes AdvPL.

| Chave                        | Uso                                                       |
| ---------------------------- | --------------------------------------------------------- |
| --advpl-align-comment <int>  | Coluna de alinhamento de comentário de fim de linha.      |
|                              | Padrão: 0 (desligado)                                     |
| --advpl-braces               | Espaçamento entre chaves.                                 |
|                              | Padrão: false                                             |
| --advpl-bracket              | Espaçamento entre colchetes.                              |
|                              | Padrão: false                                             |   
| --advpl-comma                | Espaçamento após virgulas de separção.                    |
|                              | Padrão: false                                             |
| --advpl-keywords-case        | Coloca palavras-chaves em maiúsculas ou minúsculas.       |
|  <upper|lower|ignore>        | Padrão: upper.                                            |
| --advpl-max-empty-line <int> | Máximo de linhas em branco na sequência.                  |
|                              | Padrão: 0 (sem limite)                                    |
| --advpl-math-operators       | Espaçamento em operadores matemáticos                     |
|                              | Padrão: false                                             |
| --advpl-parenthesis          | Espaçamento entre parentesis.                             |
|                              | Padrão: false                                             |
| --advpl-string-style         | Usar aspas simples ou duplas em strings.                  |
| <double-quotes|single-quotes|ignore>| Padrão: ignore                                     |
| --advplBreakLineInSemiColon  | Quebre a linha quando houver um ponto e vírgula (continuação). |  
|                              | Padrão: false                                             |
| --advplBreakLineInCodeBlock  | Quebra a linha em bloco de código.                        |
|                              | Padrão: false                                             |
| --advplExpandShortCommand    | expandir comando abreviado, p.e. 'func' para 'function    |
|                              | Padrão: false                                             |

### Uso em linha de comando

> Detalhes sobre o [uso em CLI](https://prettier.io/docs/en/cli.html).

> Em determinados sistemas operacionais ou devido a politicas de segurança, pode ser necessário configurações adicionais. Veja a documentação específica do seu sistema operacional ou acione o resposável de infra-estrutura/segurança. 

```
npm prettier --parser=advpl [options]
```

### Integração com editores

Ver [Editor Integration](https://prettier.io/docs/en/editors.html).

Nesse modo informe as opções usando o nome longo da opção sem o `--` e as letras precedidas por '-' em maiúsculas, na sessão `advpl.formatter` no arquivo `settings.json`.

```JSON
{
  ...
  "advpl.formatter": {
    "keywordsCase": "upper",
    "stringStyle": "ignore",
    "formatNumber": false,
    "operatorSpacing": false,
    "advplBreakLineInSemiColon": false,
|   "advplBreakLineInCodeBlock":  false, 
  }
  ...
```

### Embarcado

Nesse modo, informe as opções usando o nome longo das opções sem o `--`.

```Typescript
  const options: any = { ... } //Prettier Options and Formatter AdvPL Options*
  //Full source
  let result: any = prettier.format(content, {
    parser: "advpl",
    ...options,
  });
```

## Mantenedor

<table>
  <tr>
    <td align="center"><a href="https://twitter.com/TOTVSDevelopers"><img src="https://avatars2.githubusercontent.com/u/20243897?v=4?s=100" width="100px;" alt=""/><br /><sub><b>TOTVS S.A.</b></sub></a><br /><a href="#maintenance-totvs" title="Maintenance">🚧</a> <a href="#plugin-totvs" title="Plugin/utility libraries">🔌</a> <a href="#projectManagement-totvs" title="Project Management">📆</a></td>
    </tr>
</table>

## Colaboradores

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/brodao"><img src="https://avatars0.githubusercontent.com/u/949914?v=4?s=50" width="50px;" alt=""/><br /><sub><b>Alan Cândido</b></sub></a><br /><a href="https://github.com/totvs/@totvs/prettier-plugin-advpl/commits?author=brodao" title="Code">💻</a> <a href="https://github.com/totvs/@totvs/prettier-plugin-advpl/commits?author=brodao" title="Documentation">📖</a> <a href="https://github.com/totvs/@totvs/prettier-plugin-advpl/commits?author=brodao" title="Tests">⚠️</a></td>
  </tr>
</table>

<!-- markdownlint-enable -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->
