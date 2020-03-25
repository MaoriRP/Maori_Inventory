resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

server_scripts {
  "@async/async.lua",
  "@mysql-async/lib/MySQL.lua",
  "@es_extended/locale.lua",
  "locales/en.lua",
  "locales/cs.lua",
  "locales/fr.lua",
  "locales/pt.lua",
  "config.lua",
  "server/classes/c_glovebox.lua",
  "server/glovebox.lua",
  "server/esx_glovebox-sv.lua"
}

client_scripts {
  "@es_extended/locale.lua",
  "locales/en.lua",
  "locales/cs.lua",
  "locales/fr.lua",
  "locales/pt.lua",
  "config.lua",
  "client/esx_glovebox-cl.lua"
}
