return {
	config = function()
		require'nvim-autopairs'.setup{}
		local rule = require'nvim-autopairs.rule'
		local npairs = require'nvim-autopairs'
		local cond = require"nvim-autopairs.conds"
		npairs.add_rule(rule('$$', '$$', 'tex'))
		local npairs = require'nvim-autopairs'
		local Rule   = require'nvim-autopairs.rule'

		-- Add spaces after brackets
		local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
		npairs.add_rules {
			Rule(' ', ' ')
			:with_pair(function (opts)
				local pair = opts.line:sub(opts.col - 1, opts.col)
				return vim.tbl_contains({
					brackets[1][1]..brackets[1][2],
					brackets[2][1]..brackets[2][2],
					brackets[3][1]..brackets[3][2],
				}, pair)
			end)
		}
		for _,bracket in pairs(brackets) do
			npairs.add_rules {
				Rule(bracket[1]..' ', ' '..bracket[2])
				:with_pair(function() return false end)
				:with_move(function(opts)
					return opts.prev_char:match('.%'..bracket[2]) ~= nil
				end)
				:use_key(bracket[2])
			}
		end

		-- $ math modes for latex
		npairs.add_rule(rule('$', '$', 'tex'))
		npairs.add_rules({
			rule("\\begin(%w*) $", "tex")
			:replace_endpair(function(opts)
				local beforeText = string.sub(opts.line, 0, opts.col)
				local _, _, match = beforeText:find("\\begin(%w*)")
				if match and #match > 0 then
					return("\n\n\\end{" .. match .. "}")
				end
				return ''
			end)
			:with_move(cond.none())
			:use_key("<space>")
			:use_regex(true)
		})

		-- start
npairs.add_rules({
    Rule("\\begin{(%w*)}\t$", "tex")
        :replace_endpair(function(opts)
            local beforeText = string.sub(opts.line, 0, opts.col)
            local _, _, match = beforeText:find("\\begin(%w*)")
            if match and #match > 0 then
                local ret = "\n\n\\end{" .. match .. "}"
		return ret
            end
            return ''
        end)
        :with_move(cond.none())
        :use_key("<space>")
        :use_regex(true)
})
-- stop
	end
}
