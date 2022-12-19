local present, fold = pcall(require, "pretty-fold")

if not present then
  return
end

fold.setup()
