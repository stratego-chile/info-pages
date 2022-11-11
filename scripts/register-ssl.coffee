require 'json5/lib/register'

devcert = require 'devcert'
fs = require 'fs'
path = require 'path'

{ certDir, devDomainName } = require '../config.dev.json5'

do ->
  destinationFolder = path.join __dirname, '..', certDir

  if not fs.existsSync destinationFolder
    fs.mkdirSync destinationFolder

  domains = devDomainName

  try
    { key, cert, caPath } =
      await devcert.certificateFor domains, { getCaPath: true }
    fs.writeFileSync path.join(destinationFolder, 'ssl.key'), key
    fs.writeFileSync path.join(destinationFolder, 'ssl.cert'), cert
    fs.writeFileSync path.join(destinationFolder, '.capath'), caPath
  catch error
    console.error error
    process.exit 1
