local utils = require('utils')

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
-- local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
local i = ls.insert_node
local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local events = require("luasnip.util.events")
-- local ai = require("luasnip.nodes.absolute_indexer")
-- local fmt = require("luasnip.extras.fmt").fmt
-- local m = require("luasnip.extras").m
-- local lambda = require("luasnip.extras").l

return {
  s("aoc",  t({
      'use crate::problem_set::ProblemSet;',
      '',
      'const EXAMPLES1: [(&str, usize); 0] = [];',
      '',
      'const EXAMPLES2: [(&str, usize); 0] = [];',
      '',
      'fn solve(_str: &str) -> usize {',
      '    todo!()',
      '}',
      '',
      'pub fn execute(problem_set: &ProblemSet) {',
      '    match problem_set {',
      '        ProblemSet::P1(problem) => problem.execute(solve, solve, EXAMPLES1),',
      '        ProblemSet::P2(problem) => problem.execute(solve, solve, EXAMPLES2),',
      '    }',
      '}',
      '',
      '#[cfg(test)]',
      'mod tests {',
      '    use super::*;',
      '',
      '    #[test]',
      '    fn p1_examples_work() {',
      '        EXAMPLES1',
      '            .iter()',
      '            .for_each(|(input, expected)| assert_eq!(expected, &solve(input)))',
      '    }',
      '',
      '    #[test]',
      '    fn p2_examples_work() {',
      '        EXAMPLES2',
      '            .iter()',
      '            .for_each(|(input, expected)| assert_eq!(expected, &solve(input)))',
      '    }',
      '}',
    }))
  }



