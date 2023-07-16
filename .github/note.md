# Note

some note about nvim, in case I forget it

## CMD and snippet

`:'<,'>s/[word-to-remove]/[word-to-replace]/g` -> **search and replace (`/g` is global)**

`:g/[word-to-remove]/d` -> **delete all lines that contain [word-to-remove]**

`:g!/^[word-to-remove]/d` -> **delete all lines that don't start with [word-to-remove]**

`:w !sudo tee %` -> **write sudo**

`Ctrl + a` -> **increment number**, `Ctrl + x` -> **decrement number**

`echo &filetype` -> **check filetype**

`Ctrl + z` -> **suspend nvim**, `fg` -> **resume nvim**

`:set ft=html` **set current buffer to something else**

`:set ls=0` **hide laststatus**

`:m0` **move current line to line 0**

`:'<,'>norm @q` **run macro q on selected lines (V-LINE Mode)**

`f` **find character on current line, `;` to repeat `,` to reverse**

---

- Counting time elapsed in Lua

```lua
local function some_function()
  -- Your function implementation here
end

local start_time = os.clock()
some_function()
local end_time = os.clock()

local elapsed_time_seconds = end_time - start_time
local elapsed_time_milliseconds = elapsed_time_seconds * 1000
print("The function took " .. elapsed_time_milliseconds .. " milliseconds to run.")

```

- log to file

```lua
local inputAsString = vim.inspect(input)

-- Get the path to the Neovim configuration directory
local configDir = vim.fn.stdpath('config')

-- Create a file path
local filePath = configDir .. "/output.txt"

-- Open a file in write mode
local file = io.open(filePath, "w")

-- Write the string to the file
file:write(inputAsString)

-- Close the file
file:close()

```

---

`:%s/[word-to-remove]/[word-to-replace]/g` -> **search and replace in whole file**

`:%s/[word-to-remove]/[word-to-replace]/gc` -> **search and replace in whole file with confirmation**

`:%s/[word-to-remove]/[word-to-replace]/gci` -> **search and replace in whole file with confirmation and ignore case**

`:%s/[word-to-remove]/[word-to-replace]/gcI` -> **search and replace in whole file with confirmation and ignore case and case sensitive**

`:%s/[word-to-remove]/[word-to-replace]/gcIe` -> **search and replace in whole file with confirmation and ignore case and case sensitive and whole word**

`:%s/[word-to-remove]/[word-to-replace]/gcIew` -> **search and replace in whole file with confirmation and ignore case and case sensitive and whole word and match whole word**

