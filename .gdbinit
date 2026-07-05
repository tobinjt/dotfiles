# Imported from TrueNAS. I don't know if I need this, keeping just in case.
#set debug-file-directory /mnt/tank/world
add-auto-load-safe-path /usr/lib
define init_python
python
sys.path.append('/usr/share/python-gdb')
import libpython
end
end
