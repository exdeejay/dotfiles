set disassembly-flavor intel

set history save on
set history remove-duplicates unlimited
set history filename ~/.gdb_history

define init-gef
	source ~/.gdbinit-gef.py
end

define init-pwndbg
	source ~/.pwndbg/gdbinit.py
end

