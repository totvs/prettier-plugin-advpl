import { options } from './config';
import { printToken } from './printers';
import { parser as tds_parser } from '@totvs/tds-parsers';
import { IParserOptions } from '@totvs/tds-parsers/typings/config';
import { ASTNode } from '@totvs/tds-parsers/typings/ast_node';
import { AST } from 'prettier';

const PRAGMA = '--@format';

const languages = [
  {
    extensions: [
      '.prw',
      '.prx',
      '.prg',
      '.ppx',
      '.ppp',
      '.tlpp',
      '.apw',
      '.aph',
      '.apl',
      '.ahu',
    ],
    name: 'AdvPL',
    parsers: ['advpl'],
    vscodeLanguageIds: ['advpl'],
  },
];

function hasPragma(text: string) {
  return text.startsWith(PRAGMA);
}

function insertPragma(text: string) {
  return PRAGMA + '\n' + text;
}

function parser(
  text: string,
  api,
  options: IParserOptions
): ASTNode | undefined {
  try {
    const parserInfo: any = {
      debug: false,
      filepath: options.filepath,
      parser: options.parser,
      fileext: options.fileext,
    };

    const result: any = tds_parser(text + '\n', parserInfo); //EOL obrigatório na última linha
    if (result.error) {
      throw result.error;
    }

    return result.ast;
  } catch (error) {
    if (error.location) {
      console.error(
        `Sintax error: [${error.location.start.line}:${error.location.start.column}] ${error.message}`
      );
    } else {
      console.error(error);
    }
    throw error;
  }

  return undefined;
}

const parsers = {
  advpl: {
    parse: (text, api, options) => {
      return parser(text, api, options);
    },
    astFormat: 'advpl-token',
    hasPragma: hasPragma,
    insertPragma: insertPragma,
  },
};

function preprocess(ast: AST, options: object): AST {
  return ast;
}

const printers = {
  'advpl-token': {
    print: printToken,
    insertPragma: insertPragma,
    preprocess: preprocess,
  },
};

//necessário exportar dessa forma para ser reconhecido como adicional do Prettier.
module.exports = {
  name: 'prettier-plugin-advpl',
  languages,
  parsers,
  printers,
  options,
};
