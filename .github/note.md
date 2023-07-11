**_WARNING: This configuration is quite disorganized and riddled with bugs._**

`:'<,'>s/[word-to-remove]/[word-to-replace]` -> **search and replace**

`:w !sudo tee %` -> **write sudo**

`Ctrl + a` -> **increment number**, `Ctrl + x` -> **decrement number**

`echo &filetype` -> **check filetype**

`Ctrl + z` -> **suspend nvim**, `fg` -> **resume nvim**

`:set ft=html` **set current buffer to something else**

`:set ls=0` **hide laststatus**

`:m0` **move current line to line 0**

`:'<,'>norm @q` **run macro q on selected lines (V-LINE Mode)**

---

Counting time elapsed in Lua

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
