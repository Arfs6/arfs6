local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local i = ls.insert_node
local t = ls.text_node
local fmta = require("luasnip.extras.fmt").fmta
return {
	s(
		{
			trig = "star",
			},
		fmta([[
		\documentclass{article}
		\usepackage[left=1in,right=1in,top=1in,bottom=1in]{geometry}
		\usepackage{amsmath}
		\usepackage{amsfonts}
		\usepackage{amssymb}
		\usepackage{booktabs}
		\usepackage{enumerate}
		\title{<>}
		\author{Abdulqadir Ahmad}
		\begin{document}
		\maketitle
		\tableofcontents
		\section{<>}
		% End Section
		\end{document}
		]], {i(1), i(2)})
	),

	s(
		{
			trig = "tbl",
		},
		fmta([[
		\begin{table}[h]
		\caption{<>}
		\centering
		\begin{tabular}{<>}
		\toprule
		<> \\
		\midrule
		<> \\
		\bottomrule
		\end{tabular}
		\end{table}
		]],
			{i(1), i(2), i(3), i(4)})
	),
	s(
		{
			trig = ";vc",
			snippetType = "autosnippet",
		},
		{
			t("\\vec{"),
			i(0),
			t("}"),
		}
	),
	s(
		{
			trig = ";*",
			desc = "Write \times",
			snippetType = "autosnippet",
		},
		t("\\times")
	),
	s(
		{
			trig = ";lan",
			desc = "Writes \\langle.",
			snippetType = "autosnippet",
		},
		t("\\langle")
	),
	s(
		{
			trig = ";ran",
			desc = "Writes \\rangle.",
			snippetType = "autosnippet",
		},
		t("\\rangle")
	),
	s(
		{
			trig = ";tt",
			desc = "\\text command in math mode",
			snippetType = "autosnippet",
		},
		fmta([[\text{<>}]], {i(0)})
	),
	s(
		{
			trig = ";/",
			desc = "\\frac command",
			snippetType = "autosnippet",
		},
		fmta("\\frac{<>}{<>}", {i(1), i(2)})
	),
	s(
		{
			trig = ";ra",
			desc = "Writes \\rightarrow",
			snippetType = "autosnippet",
		},
		t("\\rightarrow")
	)
}
