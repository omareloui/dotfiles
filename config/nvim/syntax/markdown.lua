vim.cmd [[
  " ZK
  syn region markdownWikiLink matchgroup=markdownLinkDelimiter start="\[\[" end="\]\]" contains=markdownUrl keepend oneline concealends
  syn region markdownLinkText matchgroup=markdownLinkTextDelimiter start="!\=\[\%(\%(\_[^][]\|\[\_[^][]*\]\)*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" nextgroup=markdownLink,markdownId skipwhite contains=@markdownInline,markdownLineStart concealends
  syn region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")" contains=markdownUrl keepend contained conceal

  " Lists
  syn match  MarkdownListItem       "^\s*[-*+]\s\+"   contains=MarkdownListTab,MarkdownListBullet2
  syn match  MarkdownListItem       "^\s*\d\+\.\s\+"  contains=MarkdownListTab
  syn match  MarkdownListTab        "^\s*\*"          contained contains=MarkdownListBullet1
  syn match  MarkdownListBullet1    "\*"              contained conceal cchar=•
  syn match  MarkdownListBullet2    "[-*+]"           contained conceal cchar=•

  " Link
  syn region MarkdownLink matchgroup=MarkdownDelimiter start="\\\@<!\[" end="\]\ze\s*[[(]" skipwhite oneline concealends cchar=→
]]
--
