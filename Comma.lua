return function(n)
	n = tostring(string.format("%18.0f", tonumber(n) or 0))

	n = (tostring(n):reverse( ):gsub("(%d%d%d)", "%1,"):reverse( )..(tostring(n):match("%.%d+") or "")):gsub("^,", "")
    
	n = string.gsub(n, "%s+", "")
	n = string.sub(n, (string.sub(n, 0, 1) == "," and 2 or 0))
	return n
end