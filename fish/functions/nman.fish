function nman -d 'Narrow MANual search Invoke man command with the environment variable MANWIDTH 80 is set.'
    env MANWIDTH=80 man $argv
end
