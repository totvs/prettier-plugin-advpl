//import { util } from "prettier";
//const { printDocToDebug } = require("prettier").doc.debug;

import { util } from "prettier";
import { ASTNode, EASTType } from "tds-parsers";
import AST = require("tds-parsers/lib/ast_node");

const {
  concat,
  join,
  line,
  ifBreak,
  group,
  hardline,
  softline,
  fill,
  indent,
  dedent,
  trim,
  markAsRoot
} = require("prettier").doc.builders;

const { stripTrailingHardline, removeLines } = require("prettier").doc.utils;

function buildProgram(path, print, options) {
  const node: AST.ASTNode = path.getValue();
  const result = concat(path.map(print, 'children'));

  return result;
}

function buildBlock(path, print, options) {
  const node: AST.ASTNode = path.getValue();

  const source = path.map(print, "source");
  const children = path.map(print, "children");

  return concat([indent(source), children, dedent([])]);
}

function buildArgumentList(path, print, options) {
  const open = path.map(print, "children");

  return concat(open);
}

function buildKeyword(path, print, options) {
  const node: AST.ASTNode = path.getValue();
  let value = node.source;

  if (options["advplExpandShortCommand"] && node.getAttribute("command")) {
    value = node.getAttribute("command");
  }

  if (options["advplKeywordsCase"] === "upper") {
    value = value.toUpperCase();
  } else if (options["advplkeywordsCase"] === "lower") {
    value = value.toLowerCase();
  }

  return value;
}

function buildWhiteSpace(path, print, options) {
  const node: AST.ASTNode = path.getValue();
  let value = node.source;

  if (options.useTabs) {
    value = value.replace(" ".repeat(options.tabWidth), "\t");
  } else {
    value = value.replace(/\\t/g, " ".repeat(options.tabWidth));
  }

  return value;
}

function buildEndLine(path, print, options) {

  return concat(path.map(print, "source"));
}

function buildNewLine(path, print, options) {
  const node: AST.ASTNode = path.getValue();
  const value = node.source;
  let result: any[] = value.split("\n");
  result.fill(line);

  if (options["advplMaxEmptyLines"] > 1) {
    result = result.splice(options["advplMaxEmptyLines"]);
  }

  return concat(result);
}

function buildIdentifier(path, print, options) {
  const node: AST.ASTNode = path.getValue();
  let value = node.source;

  return concat(value);
}

function buildOperator(path, print, options) {
  const node: AST.ASTNode = path.getValue();
  const value = node.source;
  let result = value;

  return result;
}

function buildOperatorBraces(path, print, options) {
  const node: AST.ASTNode = path.getValue();
  const value = node.source;
  let result = value;

  if (options["advplBraces"]) {
    result = (result === "{") ? "{ " : " }";
  }

  return result;
}

function buildOperatorBracket(path, print, options) {
  const node: AST.ASTNode = path.getValue();
  const value = node.source;
  let result = value;

  if (options["advplBracket"]) {
    result = (result === "[") ? "[ " : " ]";
  }

  return result;
}

function buildOperatorMath(path, print, options) {
  const node: AST.ASTNode = path.getValue();
  const value = node.source;
  let result = value;

  if (options["advplMathOperators"]) {
    result = " " + result + " ";
  }

  return result;
}

function buildOperatorParenthesis(path, print, options) {
  const node: AST.ASTNode = path.getValue();
  const value = node.source;
  let result = value;

  if (options["advplParenthesis"]) {
    result = (result === "(") ? "( " : " )";
  }

  return result;
}

function buildOperatorAssign(path, print, options) {
  const node: AST.ASTNode = path.getValue();
  const value = node.source;
  let result = value;

  return result;
}

function buildBlockComment(path, print, options) {
  const node: AST.ASTNode = path.getValue();
  const value = node.source;
  let result = value;

  return value;
}

function buildComment(path, print, options) {
  const node: AST.ASTNode = path.getValue();
  const value = node.source;
  let result = value;

  return value;
}

function buildOperatorSeparator(path, print, options) {
  const node: AST.ASTNode = path.getValue();
  const value = node.source;
  let result = value;

  if (options["advplSeparator"]) {
    result += " ";
  }

  return result;
}

function buildString(path, print, options) {
  const node: AST.ASTNode = path.getValue();
  const value = node.source;
  let result = undefined;

  if (options["advplStringStyle"] === "ignore") {
    result = value.toString();
  } else if (options["advplStringStyle"] === "single-quotes") {
    result = util.makeString(value.substring(1, value.length - 1), "'", true);
  } else {
    //double-quotes
    result = util.makeString(value.substring(1, value.length - 1), '"', true);
  }

  return result;
}

function buildNumber(path, print, options) {
  const node: AST.ASTNode = path.getValue();

  return node.source;
}

function buildDirective(path, print, options) {
  const node: AST.ASTNode = path.getValue();

  return concat(path.call(print, "source"));
}

let _builderMap;
let emptyLinesCount = 0;

function builderMap(options) {
  const map: {} = {};

  map[AST.EASTType.program] = (path, print) => buildProgram(path, print, options);
  map[AST.EASTType.block] = (path, print) => buildBlock(path, print, options);
  map[AST.EASTType.argumentList] = (path, print) => buildArgumentList(path, print, options);
  map[AST.EASTType.keyword] = (path, print) => buildKeyword(path, print, options);
  map[AST.EASTType.whiteSpace] = (path, print) => buildWhiteSpace(path, print, options);
  map[AST.EASTType.endLine] = (path, print) => buildEndLine(path, print, options);
  map[AST.EASTType.newLine] = (path, print) => buildNewLine(path, print, options);
  map[AST.EASTType.identifier] = (path, print) => buildIdentifier(path, print, options);
  map[AST.EASTType.operator] = (path, print) => buildOperator(path, print, options);
  map[AST.EASTType.operatorBraces] = (path, print) => buildOperatorBraces(path, print, options);
  map[AST.EASTType.operatorBracket] = (path, print) => buildOperatorBracket(path, print, options);
  map[AST.EASTType.operatorMath] = (path, print) => buildOperatorMath(path, print, options);
  map[AST.EASTType.operatorParenthesis] = (path, print) => buildOperatorParenthesis(path, print, options);
  map[AST.EASTType.operatorSeparator] = (path, print) => buildOperatorSeparator(path, print, options);
  map[AST.EASTType.operatorAssign] = (path, print) => buildOperatorAssign(path, print, options);
  map[AST.EASTType.comment] = (path, print) => buildComment(path, print, options);
  map[AST.EASTType.blockComment] = (path, print) => buildBlockComment(path, print, options);
  map[AST.EASTType.string] = (path, print) => buildString(path, print, options);
  map[AST.EASTType.number] = (path, print) => buildNumber(path, print, options);
  map[AST.EASTType.directive] = (path, print) => buildDirective(path, print, options);

  return map;
}

function resetFunctionMap() {
  _builderMap = undefined;
}

export function printElement(path, options, print) {
  if (!_builderMap) {
    _builderMap = builderMap(options);
  }

  const node: AST.ASTNode = path.getValue();
  const builder = _builderMap[node.type];
  let result: any = undefined;

  if (builder) {
    result = builder(path, print, options);
  }

  return result;
}

module.exports = { printElement, resetFunctionMap };
