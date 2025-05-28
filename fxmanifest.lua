fx_version 'cerulean'
games { 'gta5' }

author 'Merlin.xD'
description 'Autopilot Resource'
version '1.0.0'

shared_scripts {
    'config/config.setting.lua',
    'modules/modules.lua'
}

client_scripts {
    'config/functions/function.client.lua',
    'core/client.lua'
}

lua54 'yes'