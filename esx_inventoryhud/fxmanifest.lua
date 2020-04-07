fx_version 'adamant'

game 'gta5'

description 'MaoriRP Inventory'

version '1.0'

ui_page 'html/ui.html'

client_scripts {
  '@es_extended/locale.lua',
  'client/main.lua',
  --'client/property.lua', --default property
  'client/shop.lua',
  'client/glovebox.lua',
  'locales/en.lua',
  'locales/cs.lua',
  'locales/fr.lua',
  'locales/pt.lua',
  'client/disc-property.lua',
  'client/player.lua',
  'client/steal.lua',
  'config.lua',
  'client/trunk.lua'
}

server_scripts {
  '@async/async.lua',
  '@mysql-async/lib/MySQL.lua',
  '@es_extended/locale.lua',
  'server/main.lua',
  'server/steal.lua',
  'locales/en.lua',
  'locales/cs.lua',
  'locales/fr.lua',
  'locales/pt.lua',
  'config.lua',
  'server/classes/c_trunk.lua',
  'server/trunk.lua'
}

files {
  'html/ui.html',
  'html/css/ui.css',
  'html/css/jquery-ui.css',
  'html/js/inventory.js',
  'html/js/config.js',
  -- JS LOCALES
  'html/locales/cs.js',
  'html/locales/en.js',
  'html/locales/fr.js',
  -- IMAGES
  'html/img/bullet.png',
  'html/img/logo.png',
  -- ICONS
  'html/img/items/*.png',
  'html/img/*.png'
}

dependencies {
  'es_extended',
  'mythic_notify'
}
