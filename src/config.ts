const CATEGORY_ADVPL: string = 'ADVPL';
const SINCE: string = '0.0.0';

export const options: {} = {
  advplKeywordsCase: {
    since: SINCE,
    category: CATEGORY_ADVPL,
    type: 'choice',
    choices: [{ value: 'upper' }, { value: 'lower' }, { value: 'ignore' }],
    default: 'ignore',
    description: 'Put keywords to upper or lowser case.',
  },
  advplStringStyle: {
    since: SINCE,
    category: CATEGORY_ADVPL,
    type: 'choice',
    choices: [
      { value: 'double-quotes' },
      { value: 'single-quotes' },
      { value: 'ignore' },
    ],
    default: 'ignore',
    description: 'Start/end strings with quotes.',
  },
  advplBraces: {
    since: SINCE,
    category: CATEGORY_ADVPL,
    type: 'boolean',
    default: false,
    description: 'Spacing in Braces operator.',
  },
  advplBracket: {
    since: SINCE,
    category: CATEGORY_ADVPL,
    type: 'boolean',
    default: false,
    description: 'Spacing in Bracket operator.',
  },
  advplParenthesis: {
    since: SINCE,
    category: CATEGORY_ADVPL,
    type: 'boolean',
    default: false,
    description: 'Spacing in Parenthesis operator.',
  },
  advplComma: {
    since: SINCE,
    category: CATEGORY_ADVPL,
    type: 'boolean',
    default: false,
    description: 'Spacing in Comma operator.',
  },
  advplMathOperators: {
    since: SINCE,
    category: CATEGORY_ADVPL,
    type: 'boolean',
    default: false,
    description: 'Spacing in Mathematical operators.',
  },
  advplAlignFields: {
    since: SINCE,
    category: CATEGORY_ADVPL,
    type: 'int',
    default: 0,
    description:
      'Align field name with padding spaces in DEFINE/RECORD statment.',
  },
  advplAlignComment: {
    since: SINCE,
    category: CATEGORY_ADVPL,
    type: 'int',
    default: 0,
    description: 'End of line comment alignment column. (0, off)',
  },
  advplMaxEmptyLines: {
    since: SINCE,
    category: CATEGORY_ADVPL,
    type: 'int',
    default: 0,
    description: 'Maximum blank lines in sequence (0, no limits).',
  },
  advplBreakLineInSemiColon: {
    since: SINCE,
    category: CATEGORY_ADVPL,
    type: 'boolean',
    default: false,
    description: 'Break the line when there is a semicolon.',
  },
  advplBreakLineInCodeBlock: {
    since: SINCE,
    category: CATEGORY_ADVPL,
    type: 'boolean',
    default: false,
    description: 'Breaks the line in code block.',
  },
  advplExpandShortCommand: {
    since: SINCE,
    category: CATEGORY_ADVPL,
    type: 'boolean',
    default: true,
    description: "Expand short command, e.g. 'func' to 'function'.",
  },
};

export const prettierOptions: any = {
  printWidth: 80,
  useTabs: false,
  tabWidth: 2,
  insertPragma: false,
  requirePragma: false,
  willPrintOwnComments: true,
};
