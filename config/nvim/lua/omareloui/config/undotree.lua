local present, undotree = pcall(require, "undotree")

if not present then
  return
end

undotree.setup()
