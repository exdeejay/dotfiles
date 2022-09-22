set disassembly-flavor intel

define init-pp
	python
		import sys

		sys.path.insert(0, '~/.dotfiles/gdb-printers')
		from libstdcxx.v6.printers import register_libstdcxx_printers
		register_libstdcxx_printers (None)

		sys.path.insert(0, '~/.dotfiles/gdb-printers') 
		from libcxx.v1.printers import register_libcxx_printers 
		register_libcxx_printers (None) 
	end
end

define init-gef
	source ~/.gdbinit-gef.py
end

define init-pwndbg
	source ~/.pwndbg/gdbinit.py
	set follow-fork-mode parent
	init-pp
end

