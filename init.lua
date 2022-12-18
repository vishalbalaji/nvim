_G.getPath = function(str, sep)
 sep = sep or "/"
	return str:match("(.*" .. sep .. ")")
end
package.path = getPath(vim.env.MYVIMRC) .. "/after/plugin/?.lua;" .. package.path

require("user")
