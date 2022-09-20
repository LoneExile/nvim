local attach_to_buffer = function(output_bufnr, pattern, command)
	vim.api.nvim_create_autocmd("BufWritePost", {
		group = vim.api.nvim_create_augroup("autoRun", { clear = true }),
		pattern = pattern,
		callback = function()
			local append_data = function(_, data)
				if data then
					vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, data)
				end
			end

			vim.api.nvim_buf_set_lines(output_bufnr, 0, -1, false, { "output is : " })
			vim.fn.jobstart(command, {
				stdout_buffered = true,
				on_stdout = append_data,
				on_stderr = append_data,
			})
		end,
	})
end

-- attach_to_buffer(1, "*.py", { "py", "main.py" })

vim.api.nvim_create_user_command("AutoRun", function()
	print("AutoRun starts now ...")
	local bufnr = vim.fn.input("Bufnr: ")
	local pattern = vim.fn.input("Patturn: ")
	local command = vim.split(vim.fn.input("Command: "), " ")
	attach_to_buffer(tonumber(bufnr), pattern, command)
	-- attach_to_buffer(10 ,"*.py", { "python", "main.py" })
end, {})

-- :vnew
-- :echo nvim_get_current_buf()
