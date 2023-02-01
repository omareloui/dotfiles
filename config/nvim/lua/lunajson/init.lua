local newdecoder = require "lunajson.decoder"
local newencoder = require "lunajson.encoder"
local sax = require "lunajson.sax"

return {
  decode = newdecoder(),
  encode = newencoder(),
  newparser = sax.newparser,
  newfileparser = sax.newfileparser,
}
