fx_version 'adamant'

game 'gta5'

description 'ESX glovebox inventory'

version '2.0.1'

server_scripts {
  '@async/async.lua',
  '@mysql-async/lib/MySQL.lua',
  '@es_extended/locale.lua',
  'locales/en.lua',
  'locales/cs.lua',
  'locales/fr.lua',
  'locales/pt.lua',
  'config.lua',
  'server/classes/c_glovebox.lua',
  'server/glovebox.lua',
  'server/esx_glovebox-sv.lua'
}

client_scripts {
  '@es_extended/locale.lua',
  'locales/en.lua',
  'locales/cs.lua',
  'locales/fr.lua',
  'locales/pt.lua',
  'config.lua',
  'client/esx_glovebox-cl.lua'
}
