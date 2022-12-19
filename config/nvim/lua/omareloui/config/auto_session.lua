local present, auto_session = pcall(require, "auto-session")

if not present then
  return
end

auto_session.setup {
  auto_restore_enabled = false,
}
